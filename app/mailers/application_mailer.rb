class ApplicationMailer < ActionMailer::Base
  default from: "mahoangtienthanh@gmail.com"
  layout "mailer"
  include ApplicationHelper

  def accepted_request_club user, club
    @club = club
    @user = user
    mail(to: @user.email,
      subject: "Your request has been approve!")
  end

  def sent_request_club
    mail(to: admin.email,
         subject: "An request has been sent")
  end

  def sent_request_event user
    @user = user
    mail(to: user.email,
         subject: "An request has been sent")
  end

  def new_club_open users, club
    @club = club
    @users = users
    mail(
         bcc: users.map(&:email).uniq,
         subject: "New club open")
  end

  def new_event_create users, event
    @event = event
    @users = users
    mail(
         bcc: users.map(&:email).uniq,
         subject: "New club open")
  end

  def accepted_request_event user, event
    @event = event
    @user = user
    mail(to: @user.email,
      subject: "Your request has been approve!")
  end
end
