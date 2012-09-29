class Event < ActiveRecord::Base
  attr_accessible :description, :ends_at, :starts_at, :title
end
