class Image < ApplicationRecord
  belongs_to :album
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  mount_uploader :url, ImagesUploader
end
