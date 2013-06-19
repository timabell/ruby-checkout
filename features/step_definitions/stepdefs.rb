# TODO: Rename this file to something more meaningful when I know what that might be
# TODO: capture the currency symbol for L10n

Given(/^product (\d+) has price £(\d+\.\d+)$/) do |product_code, price|
	@product = Product.new(product_code, price)
end

When(/^product (\d+) is scanned$/) do |arg1|
	@checkout = Checkout.new()
	@checkout.scan(@product)
end

Then(/^The total should be £(\d+\.\d+)$/) do |price|
	assert_equal(@checkout.price, price)
end

