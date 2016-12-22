class Event < ApplicationRecord
  has_many :news, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :requests, as: :target, dependent: :destroy
  has_many :users, through: :user_events
  belongs_to :club

  mount_uploader :image, ImagesUploader

  validates :name, presence: true
  validates :description, presence: true,
   length: {minimum: Settings.min_description}
  validates :date_start, presence: true
  validates :duration, presence: true
  validates :location, presence: true

end
