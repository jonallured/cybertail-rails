class HerokuParser < BaseParser
  HEROKU_SIGNATURE_KEY = 'HTTP_HEROKU_WEBHOOK_HMAC_SHA256'.freeze

  def self.can_parse?(raw_hook)
    raw_hook.headers.key?(HEROKU_SIGNATURE_KEY)
  end

  private

  def verified?
    Rack::Utils.secure_compare(expected_signature, actual_signature)
  end

  def expected_signature
    payload_body = raw_hook.body
    heroku_signature = Cybertail.config.heroku_signature
    digest = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), heroku_signature, payload_body)
    Base64.encode64(digest).strip
  end

  def actual_signature
    raw_hook.headers[HEROKU_SIGNATURE_KEY]
  end

  def transform!
    'we did it!'
  end
end
