class GithubParser < BaseParser
  GITHUB_SIGNATURE_KEY = 'HTTP_X_HUB_SIGNATURE_256'.freeze

  def self.can_parse?(raw_hook)
    raw_hook.headers.key?(GITHUB_SIGNATURE_KEY)
  end

  private

  def verified?
    Rack::Utils.secure_compare(expected_signature, actual_signature)
  end

  def expected_signature
    payload_body = raw_hook.body
    hub_signature = Cybertail.config.hub_signature
    sha256 = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), hub_signature, payload_body)
    "sha256=#{sha256}"
  end

  def actual_signature
    raw_hook.headers[GITHUB_SIGNATURE_KEY]
  end

  def transform!
    'we did it!'
  end
end
