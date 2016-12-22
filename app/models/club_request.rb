class ClubRequest < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true,
    length: {minimum: Settings.min_description}

  scope :unapprove, ->{where approve: false}
end
