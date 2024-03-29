class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  private
  def validate_using_image(ins, image_aid, account_id = 0)
    if image_aid.present?
      if image = Image.where('BINARY aid = ?', image_aid).first
        unless account_id == image.account_id
          if image.private || JSON.parse(image.permission_scope).all? { |item| item.is_a?(Hash) && !item['icon'].nil? }   
            ins.errors.add(:base, '画像の所有者はアイコンに設定することを許可していません')
          end
        end
      else
        ins.errors.add(:base, '存在しない画像をアイコンに設定しようとしています')
      end
    end
  end
  def add_mca_data(object, column, add_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    add_mca_array.each do |role|
      mca_array.push(role)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
  def remove_mca_data(object, column, remove_mca_array)
    mca_array = JSON.parse(object[column.to_sym])
    remove_mca_array.each do |role|
      mca_array.delete(role)
    end
    object.update(column.to_sym => mca_array.to_json)
  end
end
