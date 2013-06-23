class Checkout
	# Inject a catalogue into the checkout. This approach would need
	# reviewing for a real app.
	# The catalogue is a hashmap of product_code => product
	def initialize(catalogue)
		@catalogue = catalogue
		@basket = []
		@total = 0
	end

	def scan(product_code)
		product = @catalogue[product_code]
		raise "product code '#{product_code}' not found" if product.nil?
		@basket << product
		@total += product.price # simplistic total
		# puts format("Scanned '%s', price £%.2f.", product.code, product.price)
	end

	def total(&promotional_rules)
		puts "calculating total"
		calculated_basket = @basket
		return @total, @cacalculated_basket
	end
end
