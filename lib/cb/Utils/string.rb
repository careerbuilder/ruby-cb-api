class String
	
	# Modified from Rails source: activesupport/lib/active_support/inflector/methods.rb
  def camelize()
    self.sub!(/^[a-z\d]*/) { $&.capitalize }
    self.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
  end
end