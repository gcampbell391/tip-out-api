class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.belongs_to :user,      null: false, foreign_key: true
      t.string :shift_type,    null: false
      t.integer :shift_hours,  null: false
      t.decimal :pay_total,    precision: 10, scale: 2
      t.string :shift_comments, 
      t.timestamps
    end
  end
end
