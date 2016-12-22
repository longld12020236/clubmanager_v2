class EventRequest < ApplicationRecord
  belongs_to :user
  belongs_to :club

  mount_uploader :image, ImagesUploader

  validates :name, presence: true
  validates :description, presence: true,
   length: {minimum: Settings.min_description}
  validates :date_start, presence: true
  validates :duration, presence: true
  validates :location, presence: true

  scope :unapprove, ->{where approve: false}
end
