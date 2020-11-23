class CommentsController < ApplicationController
  before_action :get_ticket, :get_user
  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = @user
    if @comment.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :error }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def get_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def get_user
    @user = current_user
  end
end
