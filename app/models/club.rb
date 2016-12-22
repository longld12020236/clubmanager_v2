class Club < ApplicationRecord
  has_many :user_clubs, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :requests, as: :target, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :users, through: :user_clubs
  belongs_to :organization

  mount_uploader :image, ImagesUploader

  def self.actives_club
    @club = Club.where status: true
  end

  def self.alias user_club
    Club.find(user_club.club_id).name
  end

  def self.not_join array_id
    if array_id.blank?
      self.all
    else
      self.where("id NOT IN (?)", array_id)
    end
  end


end
