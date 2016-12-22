class UserClub < ApplicationRecord
  belongs_to :user
  belongs_to :club

  scope :user_club, ->club_id do
    where club_id: club_id
  end
  scope :unactive, ->{where status: false}

  def self.user_club_scope user
    where user_id: user.id
  end

  def self.club_scope user
    where user_id: user.id
  end
end
