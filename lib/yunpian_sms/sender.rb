require 'net/http'
require 'json'
require 'yunpian_sms/result'
require 'yunpian_sms/batch_result'

class YunPianSMS::Sender

  # 云片网群发 api 最多支持同时发 1000 个号码, 超过 1000 个需要分批发
  MAX_RECIPIENT_NUMBER = 1000

  def self.template_single_send template_id, mobile, params
    uri = URI("#{YunPianSMS.server}/v2/sms/tpl_single_send.json")
    send_internal uri, template_id, mobile, params
  end

  def self.template_batch_send template_id, mobile_nos, params
    successful_count = 0
    total_fee = 0.0
    uri = URI("#{YunPianSMS.server}/v2/sms/tpl_batch_send.json")

    details = mobile_nos.each_slice(MAX_RECIPIENT_NUMBER).map do |sliced_mobile_nos|
      mobile = sliced_mobile_nos.join(',')
      result = send_internal(uri, template_id, mobile, params)
      successful_count += result.body['total_count']
      total_fee += result.body['total_fee'].to_f
      result
    end

    YunPianSMS::BatchResult.new(successful_count, total_fee, details)
  end

  private

  def self.send_internal uri, template_id, mobile, params
    res = Net::HTTP.post_form(
        uri,
        apikey: YunPianSMS.api_key,
        tpl_id: template_id,
        mobile: mobile,
        tpl_value: encode(params)
    )
    if YunPianSMS.debug_mode && YunPianSMS.logger
      YunPianSMS.logger.debug "Sms sending response code #{res.code} body #{res.body}"
    end
    json = JSON.parse(res.body)
    successful = res.kind_of?(Net::HTTPSuccess)
    YunPianSMS::Result.new(successful, json.to_hash)
  end

  def self.encode params
    encoded = params.map {|k, v| "##{URI::encode(k.to_s)}#=#{URI::encode(v)}"}.join('&')
    if YunPianSMS.debug_mode && YunPianSMS.logger
      YunPianSMS.logger.debug "Encoded tpl value #{encoded}"
    end
    encoded
  end

end
