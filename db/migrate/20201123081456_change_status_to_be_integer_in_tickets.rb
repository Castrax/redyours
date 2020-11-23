class ChangeStatusToBeIntegerInTickets < ActiveRecord::Migration[6.0]
  def change
    change_column :tickets, :status, :integer, using: 'status::integer'
  end
end
