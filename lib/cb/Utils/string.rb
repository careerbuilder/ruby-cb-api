class String
	
	# Modified from Rails source: activesupport/lib/active_support/inflector/methods.rb
  def camelize(uppercase_first_letter = true)
    if uppercase_first_letter
      self.sub!(/^[a-z\d]*/) { $&.capitalize }
    else
      self.sub!(/^(?:#{inflections.acronym_regex}(?=\b|[A-Z_])|\w)/) { $&.downcase }
    end
    self.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
  end
end