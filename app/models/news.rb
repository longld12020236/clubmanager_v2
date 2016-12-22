class News < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :event

  mount_uploader :image, ImagesUploader

  validates :content, presence: true
  validates :title, presence: true
end
