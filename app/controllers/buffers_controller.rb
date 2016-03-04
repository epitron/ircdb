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

    if params[:query].present?
      @query = params[:query]
      @page_size = 5
      @lines = @buffer.messages.search(@query)
    else
      @page_size = 35
      @lines = @buffer.messages
    end

    @lines = @lines.page(@page, since: params[:since], page_size: @page_size)
  end
  
end
