class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :airplane, index: true
      t.string :status
      t.datetime :takes_of_start_time
      t.datetime :takes_of_end_time
      t.timestamps
    end
  end
end
