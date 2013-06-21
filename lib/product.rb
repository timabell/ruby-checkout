class Product
	attr_accessor :code
	attr_accessor :price

	def initialize(code, price)
		@code = code
		@price = price
	end
end
