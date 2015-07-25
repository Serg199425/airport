class CreateAirplanes < ActiveRecord::Migration
  def change
    create_table :airplanes do |t|
   	  t.string :model_name
      t.string :registration_number
      t.timestamps
    end
  end
end
