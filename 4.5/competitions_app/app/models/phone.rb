class Phone < ApplicationRecord
  belongs_to :team

  validates :number, presence: true, format: { with: /\A\d{10,15}\z/, message: "повинен містити 10-15 цифр" }
end