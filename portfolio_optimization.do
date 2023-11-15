/*
Get monthly adjusted closing price for the converted tickers from Yahoo Finance for the period 01 JAN 2019 to 31 DEC 2022. Option *casewise*:  Specifies casewise deletion of observations. If casewise is specified, then expected returns and variance-covariance matrix are computed using only the observations that have nonmissing values for all variables in varlist.
*/
 
getsymbols TICKERLIST, fm(1) fd(1) fy(2019) lm(12) ld(31) ly(2022) frequency(m) price(adjclose) casewise clear

// Generate the capital market line, based on 100 portfolios and a risk-free rate of 0, assuming no shorts and the specified minimum and maximim weights.

cmline r_*, nport(100) rfrate(0) noshort minweight(0.00000001) maxweight(0.07)

// Calculates the expected returns using the Exponential Weighted Moving Average (EWMA) method with a constant lamda = 0.94

meanrets r_*, lew(0.94)

// Store the matrix of expected returns in a vector.

matrix mrets=r(meanrets)

// Calculates the variance-covariance matrix using EWMA merhod with a constant lambda = 0.94

varrets r_*, lew(0.94)

// Store the variance-covariance matrix in a local matrix.

matrix cov=r(cov)

// Calculates the CML using calculated expected returns and variance-covariance matrix using the EWMA method.

cmline r_*, covm(cov) mrets(mrets) nport(100) rfrate(0) noshort maxweight(0.07) minweight(0.0000000001)

// Store stock weights, standard deviation and expected return of the 100 portfolios that lie on the efficient frontier (using Stata matrices)


matrix alphacml_weights=r(walphacml)

matrix cml_port_ret=r(vrcml)

matrix cml_port_sd=r(vsdcml)

matrix sharpe_ratio=r(sharpe)

matrix port_weights_no_shorting=r(wef)

matrix port_std_dev_no_shorting=r(vsdef)

matrix port_ret_no_shorting=r(vref)

matrix port_sharpe_ratios=r(vsharpe)


// Display the return and risk of the tangency (optimal) portfolio:

display "The expected return of the tangency portfolio is " r(rop) ", and its standard deviation of returns is " r(sdop)

// Display the weight vector of the tangency portfolio

matrix list r(wop)

//  Storing weights, standard deviation, expected returns and Sharpe ratios of the efficient frontier portfolios in one matrix:

matrix portfolios = port_weights_no_shorting, port_std_dev_no_shorting, port_ret_no_shorting,port_sharpe_ratios

// Storing weights, standard deviation, expected returns of the portfolios that lie on the capital market line

matrix cml = alphacml_weights, cml_port_sd, cml_port_ret

// Exporting both matrices to Excel

xml_tab portfolios, replace sheet("Efrontier w Sharpe R") format ((S3120) (N1118)) title(Efficient Frontier Portfolios and its Sharpe Ratios (without allowing for short sales)) save(portfolios_f.xls)

xml_tab cml, replace sheet("Portfolios along the CML") format ((S3120) (N1118)) title(Capital Market Line Portfolios) save(cml.xls)

// Saves the efficient frontier and capital market line

graph save "Graph" "/Users/gavin/Documents/University/Year 1/Semester 1/20816 - SUSTAINABLE FINANCE AND ESG INVESTING/TESTING COV/stata/graphs/final/efrontier_emwa.gph", replace


 
 

