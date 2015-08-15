class BuffersController < ApplicationController

  def index
    @channels = Buffer.channels.includes(:network)
    @queries = Buffer.queries.includes(:network)
  end

  def show
    @buffer = Buffer.find(params[:id])

    # @total_pages = @buffer.messages.count / PAGE_SIZE
    @page = (params[:page] || 0).to_i
    @nextpage = @page + 1 unless @page == -1
    @prevpage = @page - 1 unless @page == 0

    # offset = @page * PAGE_SIZE

    @lines = @buffer.page(@page)
  end
  
end
