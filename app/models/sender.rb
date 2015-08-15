class Sender < ActiveRecord::Base
  self.table_name = "sender"

  def nick; sender.split("!").first; end
  def whois; sender; end
end
