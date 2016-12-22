class Album < ApplicationRecord
  has_many :images, dependent: :destroy

  belongs_to :club
  scope :album_club, ->club_id do
    where club_id: club_id
  end
  validates :name, presence: true, uniqueness: true
end
