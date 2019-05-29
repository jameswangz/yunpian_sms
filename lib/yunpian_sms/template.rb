require 'net/http'
require 'json'
require 'yunpian_sms/result'

class YunPianSMS::Template

  def self.all
    get_templates({ apikey: YunPianSMS.api_key })
  end

  def self.find template_id
    get_templates({ apikey: YunPianSMS.api_key, tpl_id: template_id })
  end

  private

  def self.get_templates(params)
    uri = URI.parse("#{YunPianSMS.server}/v2/tpl/get.json")
    if YunPianSMS.debug_mode && YunPianSMS.logger
      YunPianSMS.logger.debug "Requesting uri #{uri}..."
    end
    req = Net::HTTP::Post.new(uri)
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      req.set_form_data(params)
      http.request req
    end
    if YunPianSMS.debug_mode && YunPianSMS.logger
      YunPianSMS.logger.debug "Get Templates response status: #{res.code}, body: #{res.body}"
    end
    YunPianSMS::Result.new(res.kind_of?(Net::HTTPSuccess), JSON.parse(res.body))
  end

end
