# CCF-Portfolio-Optimization
A portfolio optimization using negatively and positively screened equity data from Refinitiv, focusing on carbon credit offsets and generation. 

## Data Description

- Data is screened using Refinitiv's `Screener` app, applying both positive and negative screening techniques.
- Adjusted time series returns are downloaded from Yahoo Finance

## Methods

- Python script is used to convert company names for screened Refinitiv data to Yahoo Finance tickers. The final tickers are stored in a .txt file.
- Use of `getsymbols` package in Stata to downloaded the tickers from Yahoo Finance
- Use of `cmline` of `mvport` package to generate the capital market line an efficient frontier. For more details and options available, see <a href="https://www.stata.com/meeting/mexico18/slides/16_Mexico18_Dorantes.pdf" title="Title">
Carlos Alberto Dorantes</a>.</p>
