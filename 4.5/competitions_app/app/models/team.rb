class Team < ApplicationRecord
  belongs_to :competition
  has_many :phones, dependent: :destroy

  validates :name, presence: true
end