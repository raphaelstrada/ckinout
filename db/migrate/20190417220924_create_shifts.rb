class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.references :employee, foreign_key: true
      t.timestamp :worked_from
      t.timestamp :worked_to
      t.datetime :business_day
      t.string :snapshot_from
      t.string :snapshot_to

      t.timestamps
    end
  end
end
