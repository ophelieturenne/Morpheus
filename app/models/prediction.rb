class Prediction < ApplicationRecord
  # validations : 
  validates :dream, presence: true
  belongs_to :user
end
