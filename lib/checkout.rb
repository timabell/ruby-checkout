class Checkout
	attr_reader :total

	def scan(product_code)
		product = @catalogue[product_code]
		if product then @total += product.price end
		puts format("Scanned '%s', price £%.2f. Subtotal £%.2f", product.code, product.price, @total)
	end

	# Inject a catalogue into the checkout. This approach would need
	# reviewing for a real app.
	# The catalogue is a hashmap of product_code => product
	def initialize(catalogue, promotional_rules)
		@catalogue = catalogue
		@total = 0
	end
end
