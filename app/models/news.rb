class News < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :event

  validates :content, presence: true
  validates :title, presence: true
end
