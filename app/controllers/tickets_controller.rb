class TicketsController < ApplicationController
  before_action :get_user, :get_ticket, only: :update
  def index
    @tickets = Ticket.where(open: true)
    @comment = Comment.new
  end

  def update
    @ticket.update(ticket_params)
    redirect_to tickets_path
  end

  private

  def get_user
    @user = current_user
  end

  def get_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.permit(:title, :description, :status, :open, :photo_url)
  end
end
