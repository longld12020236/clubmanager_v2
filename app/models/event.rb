class Event < ApplicationRecord
  has_many :news, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :requests, as: :target, dependent: :destroy
  has_many :users, through: :user_events
  belongs_to :club

  mount_uploader :image, ImagesUploader

end
