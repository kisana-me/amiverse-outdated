class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private
  def validate_using_image(ins, image_aid, account_id = 0)
    if image_aid.present?
      if image = Image.find_by(
        aid: image_aid,
        deleted: false
      )
        unless account_id == image.account_id
          if image.private || JSON.parse(image.permission_scope).all? { |item| item.is_a?(Hash) && !item['icon'].nil? }   
            ins.errors.add(:base, '画像の所有者は使用を許可していません')
          end
        end
      else
        ins.errors.add(:base, '画像が存在しません')
      end
    end
  end
  def add_mca_data(object, column, add_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    add_mca_array.each do |obj|
      mca_array.push(obj)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
  def remove_mca_data(object, column, remove_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    remove_mca_array.each do |obj|
      mca_array.delete(obj)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
  def s3_upload(key:, file:, content_type:)
    s3 = Aws::S3::Resource.new(
      endpoint: ENV["S3_LOCAL_ENDPOINT"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    obj = s3.bucket(ENV["S3_BUCKET"]).object(key)
    obj.upload_file(file, content_type: content_type, acl: 'readonly')
  end
  def s3_delete(key:)
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_LOCAL_ENDPOINT"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    s3.delete_object(bucket: ENV["S3_BUCKET"], key: key)
  end
end
