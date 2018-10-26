class AddColumnOriginalFileName < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :original_file_name, :string
  end
end
