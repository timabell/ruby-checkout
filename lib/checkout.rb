class Checkout
	attr_reader :total
	attr_reader :basket

	# Inject a catalogue into the checkout. This approach would need
	# reviewing for a real app.
	# The catalogue is a hashmap of product_code => product
	def initialize(catalogue, &promotional_rules)
		@catalogue = catalogue
		@basket = []
		@promotional_rules = promotional_rules
	end

	def scan(product_code)
		product = @catalogue[product_code]
		raise "product code '#{product_code}' not found" if product.nil?

		@basket << product
		@calculated_basket = @promotional_rules.call(@basket)
		calculate_total
		debug_items
	end

	private

	def calculate_total()
		@total = @calculated_basket.reduce(BigDecimal(0)) {
			|sum, product| sum + product.price
		}
	end

	def debug_items()
		puts "basket contents:"
		@calculated_basket.each { |product| puts format(" - item '%s', '%s', price £%.2f",
			product.code, product.name, product.price) }
		puts format(" - ** total price: £%.2f **", @total)
	end
end

