class Buffer < ActiveRecord::Base
  self.table_name = "buffer"

  has_many :lines, foreign_key: 'bufferid'
  belongs_to :network, foreign_key: 'networkid'

  # scope :with_networks, -> { includes(:network) }

  scope :channels, -> { where(buffertype: 2) }
  scope :queries, -> { where(buffertype: 4) }
  scope :server_messages, -> { where(buffertype: 1) }

  def name; buffername; end
  def messages; lines.where(type: 1); end
  def info; lines.where(type: 1024); end

  def network_name; network.name; end


  def daterange
    if lines.any?
      "#{lines.first.nicedate} - #{lines.last.nicedate}"
    end
  end

  def page(n, since: nil, page_size: 35)
    if n < 0
      offset = -(n+1) * page_size
    else
      offset = n * page_size
    end

    result = messages.includes(:sender).limit(page_size).offset(offset)

    if since
      timestamp = DateTime.parse(since).to_i
      result = result.where("time > ?", timestamp)
    end

    if n < 0
      result = result.order("messageid DESC").reverse
    end

    result
  end

end
