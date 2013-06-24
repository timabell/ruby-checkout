class Checkout
	# Inject a catalogue into the checkout. This approach would need
	# reviewing for a real app.
	# The catalogue is a hashmap of product_code => product
	def initialize(catalogue)
		@catalogue = catalogue
		@basket = []
	end

	def scan(product_code)
		product = @catalogue[product_code]
		raise "product code '#{product_code}' not found" if product.nil?
		@basket << product
		# puts format("Scanned '%s', price £%.2f.", product.code, product.price)
	end

	def total(&promotional_rules)
		puts "calculating total"
		debug_items(@basket, "current basket")
		calculated_basket = promotional_rules.call(@basket)
		debug_items(calculated_basket, "calculated basket")
		total_price = basket_total(calculated_basket)
		return total_price, calculated_basket
	end
end

def basket_total(basket)
	basket.reduce(BigDecimal(0)) { |sum, product| sum + product.price }
end

def debug_items(basket, name)
	puts "#{name} contents:"
	basket.each { |product| puts format(" - item '%s' price £%.2f", product.code, product.price) }
	total_price = basket_total(basket)
	puts format(" - ** total price: £%.2f **", total_price)
end
