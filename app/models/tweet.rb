class Tweet < ApplicationRecord
  belongs_to :customer

  validates :body, length: { minimum: 1, maximum: 250}

end