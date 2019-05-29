module YunPianSMS

  @debug_mode = true
  @server = "https://sms.yunpian.com"

  class<< self
    attr_accessor :logger, :debug_mode, :api_key
    attr_reader :server
  end
  
  require 'yunpian_sms/template'
  require 'yunpian_sms/sender'

end
