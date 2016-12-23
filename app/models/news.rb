class News < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :event
  mount_uploader :image, ImagesUploader

end
