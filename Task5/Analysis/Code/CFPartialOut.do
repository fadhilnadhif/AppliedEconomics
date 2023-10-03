* ==============================================================================
*
* Title				: Cross-fit partial out
* Aim				: Lasso analysis
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: October 2nd, 2023
*
* ==============================================================================

	** INITIALIZATION
	set more off
	clear all

	** SET GLOBAL DIRECTORY PATH
	if `"`c(os)'"' == "Windows" global path "C:/Users/fa.4982/OneDrive - Handelshögskolan i Stockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task5"
	if `"`c(os)'"' == "MacOSX"   global path = "/Users/nadhif/Library/CloudStorage/OneDrive-HandelshögskolaniStockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task5"
	cd "$path"
	
	** SET INPUT AND OUTPUT PATH
	global inputpath	"Analysis/Data"
	global outputpath	"Analysis/Results"

	cap log close
	log using "Communications/Log/Task5.log", replace 
	
	** SET GLOBAL OF ALL COVARIATES
	global MAIN			"female black hispanic othrace dep q1-q6 recall agelt35 agegt54 durable nondurable husd loc_10404-loc_10880"
	global SECORDER		"*X*"
	global ALLCOV		"$MAIN $SECORDER"
	
	** SET SEED
	set seed 20231002

/*=========================================================================*/
/*                       CROSS-FIT PARTIALING OUT                          */
/*=========================================================================*/
eststo clear
use "$inputpath/LassoAnalysis.dta", clear	

	* Plugin-formula
	eststo a1: xporegress loginuidur treatment, controls($ALLCOV) sel(plugin)  ///
					   cluster(abdt) xfold(5) resample(10) 
	lassoinfo, each
	mat B1 = r(table)
	esttab matrix(B1) using "$outputpath/LassoInfo_PF.tex", replace nomtitles label
	
	lassocoef (.,for(loginuidur) xfold(3) resample(5)) ///
			  (.,for(treatment) xfold(3) resample(5))
	mat C1 = r(coef)
	esttab matrix(C1) using "$outputpath/LassoCoef_PF.tex", replace nomtitles label

	
	* Always select, plugin-formula
	eststo a2: xporegress loginuidur treatment, controls(($MAIN) $SECORDER)  ///
						  sel(plugin) cluster(abdt) xfold(5) resample(10)
						  
	lassoinfo, each
	mat B2 = r(table)
	esttab matrix(B2) using "$outputpath/LassoInfo_PF-AS.tex", replace nomtitles label
	
	lassocoef (.,for(loginuidur) xfold(3) resample(5)) ///
			  (.,for(treatment) xfold(3) resample(5))
	mat C2 = r(coef)
	esttab matrix(C2) using "$outputpath/LassoCoef_PF-AS.tex", replace nomtitles label
			 
			 
	* Cross-validation
	eststo a3: xporegress loginuidur treatment, controls($ALLCOV) sel(cv) ///
					   cluster(abdt) xfold(5) resample(10)
	lassoinfo, each
	mat B3 = r(table)
	esttab matrix(B3) using "$outputpath/LassoInfo_CV.tex", replace nomtitles label
	
	lassocoef (.,for(loginuidur) xfold(3) resample(5)) ///
			  (.,for(treatment) xfold(3) resample(5))
	mat C3 = r(coef)
	esttab matrix(C3) using "$outputpath/LassoCoef_CV.tex", replace nomtitles label
	
	* Consolidating coefficients into one table
	esttab a1 a2 a3 using "$outputpath/CFPartialOut.tex", replace se nomtitles label 
			
*** END OF DO FILE 
	log close 
