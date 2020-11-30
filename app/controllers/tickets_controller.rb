class TicketsController < ApplicationController
  before_action :get_ticket, :check_user, only: :update
  def index
    @tickets = Ticket.where(open: true)
    @comment = Comment.new
  end

  def update
    @ticket.update(ticket_params)
    redirect_to tickets_path
  end

  private

  def get_ticket
    @ticket = Ticket.find(params[:id])
  end

  def check_user
    render status: :unprocessable_entity if current_user != @ticket.user
  end

  def ticket_params
    params.permit(:title, :description, :status, :open, :photo_url)
  end
end
