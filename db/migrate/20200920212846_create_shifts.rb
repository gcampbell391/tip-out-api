class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.belongs_to :user,      null: false, foreign_key: true
      t.string :employment_place,    null: false
      t.string :shift_date,    null: false
      t.string :shift_type,    null: false
      t.string :shift_hours,  null: false
      t.string :pay_total,    null: false
      t.string :shift_comments, 
      t.timestamps
    end
  end
end
