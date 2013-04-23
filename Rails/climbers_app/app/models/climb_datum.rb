require 'geokit'
#require 'active_record'

class ClimbDatum < ActiveRecord::Base
  attr_accessible :area, :climb_type, :description, :height, :image_url, :latitude, :location_name, :longitude, :parking_lat, :parking_long, :rock_name, :route_name, :skill_level, :state

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
