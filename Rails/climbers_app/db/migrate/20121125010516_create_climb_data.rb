class CreateClimbData < ActiveRecord::Migration
  def change
    create_table :climb_data do |t|
      t.string :state
      t.string :area
      t.string :location_name
      t.string :rock_name
      t.string :route_name
      t.string :latitude
      t.string :longitude
      t.string :parking_lat
      t.string :parking_long
      t.integer :skill_level
      t.string :climb_type
      t.integer :height
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
