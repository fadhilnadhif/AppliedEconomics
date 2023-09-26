* ==============================================================================
*
* Title				: Model selection and growth regression
* Aim				: Data cleaning 
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 22th, 2023
*
* ==============================================================================
	
	** INITIALIZATION
	set more off
	clear all

	** SET GLOBAL DIRECTORY PATH
	if `"`c(os)'"' == "Windows" global path "C:/Users/fa.4982/OneDrive - Handelshögskolan i Stockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task4"
	if `"`c(os)'"' == "MacOSX"   global path = "/Users/nadhif/Library/CloudStorage/OneDrive-HandelshögskolaniStockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task4"
	cd "$path"
	
	** SET INPUT AND OUTPUT PATH
	global inputpath	"Raw/Data"
	global outputpath	"Analysis/Data"
	
	
/*=========================================================================*/
/*                              DATA CLEANING                              */
/*=========================================================================*/

foreach j in "92_02" "02_11" {	
	** UPLOAD DATA
	import delimited "$inputpath/growthdata`j'.csv", clear
	
	drop v1
	
	la var iso3				"Country"
	la var ln_y				"Log GDP per capita at beginning of time period"
	la var growth			"GDP growth rate"
	la var hc				"Index of human capital"
	la var gvmnt_c			"Government consumption (% of GDP)"
	la var gcf				"Gross capital formation (% of GDP)"
	la var ext_bal			"External trade balance (% of GDP)"
	la var trade			"Trade (% of GDP)"
	la var inflation		"Inflation"
	la var fem_emp			"Female employment rate"
	la var tot_emp			"Total employment rate"
	la var inf_mort			"Infant mortality (per 1000)"
	la var lexp				"Life expectancy"
	la var tfr				"Total fertility rate"
	la var age_dep_old		"Age dependency ratio (old)"
	la var age_dep_young	"Age dependency ratio (young)"
	la var urban			"Urban (% of pop)"
	la var yrsoffc			"Years in office of executive"
	la var military			"Dummy: Executive is military"
	la var competitiveness_leg	"Political competitiveness: Legislative definition"
	la var competitiveness_exec	"Political competitiveness: Executive definition"
	la var parliamentary	"Dummy: Parliamentary system"
	la var presidential		"Dummy: Presidential system"
	la var voice			"Voice and influence in government (1996 in early dataset)"
	la var stability		"Political stability (1996 in early dataset)"
	la var effectiveness	"Effectiveness of government (1996 in early dataset)"
	la var regulation		"Regulatory quality (1996 in early dataset)"
	la var law				"Rule of law (1996 in early dataset)"
	la var corruption		"Low corruption measure (1996 in early dataset)"
	

	
	** SAVE DATA
	save "$outputpath/growthdata`j'.dta", replace 
}
**** END OF DO FILE 
