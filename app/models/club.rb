class Club < ApplicationRecord
  has_many :user_clubs, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :requests, as: :target, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :users, through: :user_clubs
  belongs_to :organization

  def self.alias user_club
    Club.find(user_club.club_id).name
  end

  def self.actives_club
    @club = Club.where status: true
  end

  def self.club_not_join user
    array_attribute = UserClub.club_to_array(user)
    if array_attribute.blank?
      Club.all
    else
      Club.where("id NOT IN (?)", array_attribute)
    end
  end
end
