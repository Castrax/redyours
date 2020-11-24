class UserMailer < ApplicationMailer
  default from: 'contact@mathilderobert.com'
  before_action :set_user, :set_comment

  def welcome_ticket_email
    @ticket = @user.tickets.last
    @url_ticket = "/tickets/#{@ticket.id}"
    mail(to: @user.email, subject: "You have a new ticket assigned : #{@ticket.title}")
  end

  def comment_email
    mail(to: @user.email, subject: "You have a new comment on : #{@comment.ticket.title}")
  end

  private

  def set_user
    @user = params[:user]
  end

  def set_comment
    @comment = params[:comment]
  end
end
