class Image < ApplicationRecord
  belongs_to :album
  belongs_to :user

  mount_uploader :url, ImagesUploader
end
