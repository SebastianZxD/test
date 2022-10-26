class CreateNewlinks < ActiveRecord::Migration[7.0]
  def change
    create_table :newlinks do |t|
      t.string :url
      t.string :slug

      t.timestamps
    end
  end
end
