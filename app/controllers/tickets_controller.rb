class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(open: true)
    @comment = Comment.new
  end
end
