class AddExpireToNewlinks < ActiveRecord::Migration[7.0]
  def change
    add_column :newlinks, :expire, :datetime
  end
end
