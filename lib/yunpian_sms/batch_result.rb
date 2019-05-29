class YunPianSMS::BatchResult

  attr_reader :successful_count, :total_fee, :details

  def initialize(successful_count, total_fee, details)
    @successful_count = successful_count
    @total_fee = total_fee
    @details = details
  end

end