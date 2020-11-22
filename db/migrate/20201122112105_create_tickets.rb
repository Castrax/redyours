class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.boolean :open

      t.timestamps
    end
  end
end
