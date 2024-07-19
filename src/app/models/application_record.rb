class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include ImageTools

  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end
  def human_attribute_enum(attr_name)
    self.class.human_attribute_enum_value(attr_name, self.send("#{attr_name}"))
  end

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

  def add_array(object:, column:, add_array:, save: false)
    original_array = JSON.parse(object[column.to_sym])
    add_array.each do |obj|
      original_array.push(obj)
    end
    object[column.to_sym] = original_array.to_json
    if save
      object.save
    end
  end
  def remove_array(object:, column:, remove_array:, save: false)
    original_array = JSON.parse(object[column.to_sym])
    remove_array.each do |obj|
      original_array.delete(obj)
    end
    object[column.to_sym] = original_array.to_json
    if save
      object.save
    end
  end

  def object_url(key: '')
    bucket_key = File.join(ENV["S3_BUCKET"], key)
    url = File.join(ENV["S3_PUBLIC_ENDPOINT"], bucket_key)
    return url
  end
  def signed_object_url(key: '', expires_in: 10)
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_PUBLIC_ENDPOINT"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    signer = Aws::S3::Presigner.new(client: s3)
    url = signer.presigned_url(
      :get_object,
      bucket: ENV["S3_BUCKET"],
      key: "#{key}",
      expires_in: expires_in
    )
    return url
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
