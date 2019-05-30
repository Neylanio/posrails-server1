class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fullName
      t.date :birthData

      t.timestamps
    end
  end
end
