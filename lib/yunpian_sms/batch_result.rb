class YunPianSMS::BatchResult

  attr_reader :successful_count # 总发送成功条数, 一条短信超过 70 字会被拆分成多条
  attr_reader :successful_people # 发送成功列表
  attr_reader :failed_people # 发送失败列表
  attr_reader :total_fee # 总花费金额
  attr_reader :details # 发送明细

  def initialize(
    successful_count,
    successful_people,
    failed_people,
    total_fee,
    details)

    @successful_count = successful_count
    @successful_people = successful_people
    @failed_people = failed_people
    @total_fee = total_fee
    @details = details
  end

end