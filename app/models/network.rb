class Network < ActiveRecord::Base
  self.table_name = "network"
  has_many :buffers, foreign_key: 'networkid'

  def name; networkname; end

  def channels; buffers.channels; end
  def queries; buffers.queries; end
end
