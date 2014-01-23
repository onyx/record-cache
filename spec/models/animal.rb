class Animal < ActiveRecord::Base
  inheritance_column = :species
  cache_records :store => :shared
end

class Dog < Animal
end
