class Buffer < ActiveRecord::Base
  self.table_name = "buffer"

  has_many :lines, foreign_key: 'bufferid'
  belongs_to :network, foreign_key: 'networkid'

  # scope :with_networks, -> { includes(:network) }

  scope :channels,        -> { where(buffertype: 2) }
  scope :queries,         -> { where(buffertype: 4) }
  scope :server_messages, -> { where(buffertype: 1) }

  def name;     buffername; end
  def messages; lines.messages; end
  def info;     lines.where(type: 1024); end

  def daterange
    if lines.any?
      "#{lines.first.nicedate} - #{lines.last.nicedate}"
    end
  end

end
