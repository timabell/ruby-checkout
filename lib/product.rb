class Product
	attr_accessor :code
	attr_accessor :price
	attr_accessor :name

	def initialize(code, name, price)
		@code = code
		@price = price
		@name = name
	end
end
