class AddDescriptionToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :description, :text
  end
end
