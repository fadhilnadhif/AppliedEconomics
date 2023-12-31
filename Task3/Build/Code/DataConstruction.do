* ==============================================================================
*
* Title				: The WVS and Unsupervised Learning
* Aim				: Data cleaning 
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 16th, 2023
*
* ==============================================================================
	
	** INITIALIZATION
	set more off
	clear all

	** SET GLOBAL DIRECTORY PATH
	cd "$path"
	
	** SET INPUT AND OUTPUT PATH
	global inputpath	"Raw/Data"
	global outputpath	"Analysis/Data"
	
	** INSTALL PACKAGES
	ssc install missings, replace
	
/*=========================================================================*/
/*                          DATA CLEANING FOR WVS                          */
/*=========================================================================*/
	
	** UPLOAD DATA: WVS
	use "$inputpath/WV6_Data_stata_v20201117.dta", clear
	
	
	** CHOOSING THE ONE-DIMENSIONAL VALUE VARIABLES 
	keep C_COW_ALPHA V2 V4-V11 V49-V56 V59 V70-V79 V90-V139 V152-V169 V170-V175 ///
		 V181-V186 V188-V191 V192-V197 V198-V210
	rename C_COW_ALPHA COW
	
	** CHECK VARIABLE VALUE
	codebook
	
	** RECODE NEGATIVE VALUE INTO MISSING VALUE
	qui ds, has(type numeric)
	cap confirm variable `r(varlist)'
	if _rc == 0 foreach v of varlist `r(varlist)' {
		replace `v' = . if `v' < 0
	}
	// Nothing changed. All missing values have been recoded from raw dataset
	
	** COLLAPSING 
	foreach v of var `r(varlist)' {
		local l`v' : variable label `v'
        if `"`l`v''"' == "" {
 		local l`v' "`v'"
		}
	}
	
	collapse (first) COW (mean) V4-V11 V49-V56 V59 V70-V79 V90-V139 V152-V169 ///
					V170-V175 V181-V186 V188-V191 V192-V197 V198-V210, by(V2)
	
	qui ds, has(type numeric)
	foreach v of var `r(varlist)' {
		la var `v' `"`l`v''"'
	}
	
	** DROP VARIABLES THAT HAVE MISSING VALUES
	qui missings report
	drop `r(varlist)'
	drop V125_* // not all countries have this

	
	** GENERATE STRING COUNTRY VARIABLES FOR TRANSPOSING
	decode V2, gen(country)
	order country, first
	replace country = subinstr(country, " ", "", .)
	replace country = "TrinidadTobago" if country == "TrinidadandTobago"
	rename V2 countryID
	
	** SAVE DATA
	save "$outputpath/WV6_Data_ORI.dta", replace 
	
	** GENERATE NORMALIZED VARIABLES
	ds, has(type float)
	foreach v of varlist `r(varlist)' {
		tempvar meanvar
		tempvar sdvar
		egen `meanvar' = mean(`v')
		egen `sdvar' = sd(`v')
		replace `v' = (`v'-`meanvar')/`sdvar'
		la var `v' `"`l`v'' (Normalized)"'
	}
	cap drop __*
	
	** SAVE DATA
	save "$outputpath/WV6_Data_NOR.dta", replace 
	
**** END OF DO FILE 
