require 'factory_girl'

FactoryGirl.define do

  factory :city, :class => City do
    name "Austin, TX"
  end

end
