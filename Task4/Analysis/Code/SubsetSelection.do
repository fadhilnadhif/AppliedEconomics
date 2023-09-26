* ==============================================================================
*
* Title				: Model selection and growth regression
* Aim				: Within-time period prediction 
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 26th, 2023
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
	global inputpath	"Analysis/Data"
	global outputpath	"Analysis/Results"

	cap log close
	log using "$outputpath/Task4.log", replace 

/*=========================================================================*/
/*                                EXERCISE 1                               */
/*=========================================================================*/

/*** DATA PREPARATION ***/
use "$inputpath/growthdata92_02.dta", clear	

	* Drop 20% of sample randomly 
	set seed 20230927
	gen random = runiform()
	drop if random > 0.8
	drop random
	
	* Keep the out-of-sample country for the next period
	preserve
	keep iso3
	tempfile countryinsample
	save `countryinsample', replace
	restore 
	
/*** SUBSET SELECTION ***/

** 80% Subsample
	** Forward stepwise selection
	stepwise, pr(.2) pe(.1) forward: reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

	** Backward stepwise selection
	stepwise, pr(.2) pe(.1): reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

** Full Sample 
use "$inputpath/growthdata92_02.dta", clear	

	** Forward stepwise selection
	stepwise, pr(.2) pe(.1) forward: reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

	** Backward stepwise selection
	stepwise, pr(.2) pe(.1): reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption


/*=========================================================================*/
/*                                EXERCISE 2                               */
/*=========================================================================*/

/*** DATA PREPARATION ***/
use "$inputpath/growthdata02_11.dta", clear	

	* Drop 20% of sample randomly 
	set seed 20230927
	gen random = runiform()
	drop if random > 0.8
	drop random
	
	* Keep the out-of-sample country for the next period
	preserve
	keep iso3
	tempfile countryinsample
	save `countryinsample', replace
	restore 
	
/*** SUBSET SELECTION ***/

** 80% Subsample
	** Forward stepwise selection
	stepwise, pr(.2) pe(.1) forward: reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

	** Backward stepwise selection
	stepwise, pr(.2) pe(.1): reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

** Full Sample 
use "$inputpath/growthdata02_11.dta", clear	

	** Forward stepwise selection
	stepwise, pr(.2) pe(.1) forward: reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

	** Backward stepwise selection
	stepwise, pr(.2) pe(.1): reg ln_y gvmnt_c gcf ext_bal trade inflation fem_emp tot_emp inf_mort lexp tfr age_dep_old age_dep_young urban yrsoffc military competitiveness_leg competitiveness_exec parliamentary presidential voice stability effectiveness regulation law corruption

	log close 
*** END OF DO FILE 
