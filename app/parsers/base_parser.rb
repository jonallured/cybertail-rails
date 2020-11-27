class BaseParser
  def self.can_parse(_raw_hook)
    raise 'Implement in subclass'
  end

  def self.parse(raw_hook)
    new(raw_hook).parse
  end

  attr_reader :raw_hook

  def initialize(raw_hook)
    @raw_hook = raw_hook
  end

  def parse
    return unless verified?

    transform!
  end

  private

  def verified?
    raise 'Implement in subclass'
  end

  def transform!
    raise 'Implement in subclass'
  end
end
