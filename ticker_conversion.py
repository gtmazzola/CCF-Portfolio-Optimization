from yahooquery import search



def find_ticker_by_company_name(company_name):
    try:
        # Use yahooquery to search for the ticker
        result = search(company_name)

        # Check if search results are available
        if 'quotes' in result and result['quotes']:
            ticker = result['quotes'][0]['symbol']
            return ticker
        else:
            print(f"Ticker not found for company: {company_name}")
            return None
    except Exception as e:
        print(f"Error finding ticker for {company_name}: {e}")
        return None


# List of company names
company_names = [List of company names]

# Find Yahoo Tickers for the given company names
yahoo_tickers = [find_ticker_by_company_name(name) for name in company_names]

# Save results to a text file
with open('yahoo_tickers.txt', 'w') as file:
    for name, yahoo_ticker in zip(company_names, yahoo_tickers):
        file.write(f"{yahoo_ticker}\n")



# Display the results
for name, yahoo_ticker in zip(company_names, yahoo_tickers):
    print(f"Company: {name} -> Yahoo Ticker: {yahoo_ticker}")

