class EventRequest < ApplicationRecord
  belongs_to :user
  belongs_to :club

  scope :unapprove, ->{where approve: false}
end
