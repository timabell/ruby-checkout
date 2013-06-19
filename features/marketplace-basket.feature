Feature: An online marketplace with price totalling
	In order to avoid uncertainty about total costs
	The total price should be displayed after items scanned

	Scenario: Single item scanned
		Given product 001 has price £9.25
		When product 001 is scanned
		Then The total should be £9.25
