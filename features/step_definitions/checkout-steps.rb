# TODO: Rename this file to something more meaningful when I know what that might be
# TODO: capture the currency symbol for L10n

Given(/^these products are available:$/) do |table|
	@checkout = Checkout.new()
	@catalogue = Catalogue.new()
	# table is a Cucumber::Ast::Table
	@catalogue << Product.new("666", 89.91)
end

When(/^product "(.*?)" is scanned$/) do |arg1|
	@checkout.scan(@product)
end

Then(/^The total should be £(\d+\.\d+)$/) do |price|
	expect(@checkout.price).to eq(price)
end
