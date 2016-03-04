class TimestampSerializer
  def self.load(integer)
    integer && Time.at(integer)
  end

  def self.dump(datetime)
    datetime.to_i
  end
end

class Line < ActiveRecord::Base
  self.table_name         = "backlog"
  self.primary_key        = "messageid"
  self.inheritance_column = :_type_disabled
  
  # default_scope { includes(:sender) }

  belongs_to :buffer, foreign_key: :bufferid
  belongs_to :sender, foreign_key: :senderid
  
  def nick; sender.nick; end
  def whois; sender.whois; end

  scope :messages, -> { where(type: 1) }

  COLORS = 10

  def self.search(query)
    matcher = query.split.join("%")
    messages.where("message like ?", "%#{matcher}%")
  end

  def self.page(n, since: nil, page_size: 35)
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



  def nickcolor
    hash = nick.chars[1..-2].map(&:ord).sum + nick.size
    "color#{hash % COLORS}"
  end

  def formatted_message
    m =  ERB::Util.html_escape(message)
    m.
      # link to urls
      gsub(/https?:\/\/\S+[^>\)\]\s]/) { |url| "<a href='#{url}' rel='noreferrer' target='_blank'>#{url}</a>" }.
      # bold chars
      gsub("\b").with_index { |char, count| count % 2 == 0 ? "<b>" : "</b>" }.
      html_safe
  end

  def date
    time.strftime("%Y-%m-%d")
  end

  def nicedate
    time.strftime("%b %e, %Y")
  end

  def nicetime
    time.strftime("%l:%M %p")
  end

  serialize :time, TimestampSerializer
end
