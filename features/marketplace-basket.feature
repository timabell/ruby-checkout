Feature: An online marketplace with price totalling

	Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

	If you spend over £60, then you get 10% of your purchase
	If you buy 2 or more lavender hearts then the price drops to £8.50.

	Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

	Background:
		Given these products are available:
		| Product Code  | Name                   | Price  |
		| 001           | Lavender heart         | £9.25  |
		| 002           | Personalised cufflinks | £45.00 |
		| 003           | Kids T-shirt           | £19.95 |

	Scenario: Single item
		When product "001" is scanned
		Then The total should be £9.25

	Scenario: Non-existent product
		* Scanning product "666" scanned should cause an error

	Scenario: 10% off because over £60 (£74.20 - £7.42 = £66.78)
		When product "001" is scanned
		And product "002" is scanned
		And product "003" is scanned
		Then The total should be £66.78

	Scenario: Bulk discount, 75p off "001"
		When product "001" is scanned
		And product "002" is scanned
		And product "001" is scanned
		Then The total should be £36.95

	Scenario: Bulk discount + 10% off
		When product "001" is scanned
		And product "002" is scanned
		And product "001" is scanned
		And product "003" is scanned
		Then The total should be £73.76
