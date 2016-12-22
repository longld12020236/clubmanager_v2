class EventRequest < ApplicationRecord
  belongs_to :user
  belongs_to :club

  mount_uploader :image, ImagesUploader

  scope :unapprove, ->{where approve: false}
end
