class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :news

  validates :content, presence: true, length: {minimum: Settings.min_comment}

end
