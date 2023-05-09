class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.integer :duration_minutes
      t.time :start_time
      t.date :date
      t.integer :host_id

      t.timestamps
    end
  end
end
