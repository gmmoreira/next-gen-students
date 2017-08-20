class Student < ApplicationRecord
  validates_presence_of *%i[first_name last_name email]
end
