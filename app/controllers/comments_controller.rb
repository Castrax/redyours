class CommentsController < ApplicationController
  before_action :set_ticket, :set_user

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = @user
    if @comment.save
      if @user != @ticket.user
        UserMailer.with(user: @ticket.user, comment: @comment).comment_email.deliver_now
      end
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render :error }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_user
    @user = current_user
  end
end
