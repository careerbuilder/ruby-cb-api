class String
	
	# Modified from Rails ActiveSupport::Inflector
  # Source: activesupport/lib/active_support/inflector/methods.rb, line 55
  # Documentation:  http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize
  def camelize()
    self.sub!(/^[a-z\d]*/) { $&.capitalize }
    self.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
  end
end
