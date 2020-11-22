class AddPhotoUrlToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :photo_url, :string
  end
end
