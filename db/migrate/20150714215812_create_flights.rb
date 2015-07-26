class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :airplane, index: true
      t.string :status
      t.datetime :take_off_start_time
      t.datetime :take_off_end_time
      t.timestamps
    end
  end
end
