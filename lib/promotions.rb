class Promotions
	def promotion_rules
		lambda { |basket|
			calculated_basket = basket.clone
			hearts = basket.count { |item| item.code == "001" }
			if hearts > 1
				calculated_basket << Product.new( "---", "heart multi-buy discount", BigDecimal(hearts * -0.75, 2) )
			end
			total = calculated_basket.reduce(BigDecimal(0)) {
				|sum, product| sum + product.price
			}
			# puts format(" - ** interim total price: £%.2f **", total)
			if total > 60
				# take 10% off, rounded down to be tight (to match
				# numbers in the spec)
				discount = BigDecimal(total * 0.1, 1).floor(2)
				calculated_basket << Product.new( "---", "10% off", -discount )
			end
			# return a modified basket with a discount
			calculated_basket
		}
	end
end
