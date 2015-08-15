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

  COLORS = 10

  def nickcolor
    hash = nick.chars[1..-2].map(&:ord).sum + nick.size
    "color#{hash % COLORS}"
  end

  def formatted_message
    message.
      # link to urls
      gsub(%r{https?://[^\s)>]+}) { |url| "<a href='#{url}' rel='noreferrer' target='_blank'>#{url}</a>" }.
      # bold chars
      gsub("\b").with_index { |char, count| count % 2 == 0 ? "<b>" : "</b>" }.
      html_safe
  end

  def nicedate
    time.strftime("%b %e, %Y")
  end

  def nicetime
    time.strftime("%l:%M %p")
  end

  serialize :time, TimestampSerializer
end
