class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(open: true)
  end
end
