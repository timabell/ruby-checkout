# TODO: Rename this file to something more meaningful when I know what that might be
# TODO: capture the currency symbol for L10n

require 'bigdecimal' # avoid floats for currency as tends to cause rounding errors

# Transform a table of products into a catalogue hashmap of product objects
Transform /^table:Product Code,Name,Price$/ do |table|
	# Plain english table headings to ruby symbol style
	table.map_headers! {|header| header.downcase.gsub(/\s+/,"_").to_sym }
	# Convert table to hashmap of products keyed on product code
	Hash[table.hashes.map do |row|
		[ row[:product_code], product_from(row) ]
	end
	]
end

def product_from(row)
	# Extract the decimal from the price column and create a product object
	Product.new( row[:product_code], BigDecimal(row[:price].delete("£")) )
end

Given(/^these products are available:$/) do |catalogue|
	@checkout = Checkout.new(catalogue)
	# table is a Cucumber::Ast::Table
end

When(/^product "(.*?)" is scanned$/) do |product_code|
	@checkout.scan(product_code)
end

Then(/^The total should be £(\d+\.\d+)$/) do |price|
	puts "checking total"
	actual_total, basket = @checkout.total do |scanned|
		puts "promotional rules applied"
		puts "discounting ", scanned
	end

	puts basket

	expect(actual_total).to eq(BigDecimal(price))
end

Given(/^Scanning product "(.*?)" scanned should cause an error$/) do |arg1|
	lambda do
		@checkout.scan(product_code)
	end.should raise_error()
end
