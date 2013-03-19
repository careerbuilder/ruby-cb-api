module Cb::Utils::Country
  def self.get_supported
    %w(AH,BE,CA,CC,CE,CH,CN,CP,CS,CY,DE,DK,E1,ER,ES,EU,F1,
       FR,GC,GR,I1,IE,IN,IT,J1,JC,JS,LJ,M1,MY,NL,NO,PD,PI,
       PL,RM,RO,RX,S1,SE,SF,SG,T1,T2,UK,US,WH,WM,WR)
  end

	def self.is_valid?(code)
		get_supported.include? code
	end

	def self.inject_convenience_methods
		get_supported.each do | code |
			#self.define_method(#{code}) do | throw_away |
			#	#code
			#end
		end
	end
end