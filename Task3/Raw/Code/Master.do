* ==============================================================================
*
* Title				: Task 3 Applied Empirical Economics 
* Aim				: Master Do File 
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 20th, 2023
*
* ==============================================================================

	** INITIALIZATION
	set more off
	clear all
	
	** SET GLOBAL DIRECTORY PATH
	if `"`c(os)'"' == "Windows" global path "C:/Users/fa.4982/OneDrive - Handelshögskolan i Stockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task3"
	if `"`c(os)'"' == "MacOSX"   global path = "/Users/nadhif/Library/CloudStorage/OneDrive-HandelshögskolaniStockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task3"
	cd "$path"
	
	** LOG FILE
	log using "Communications/Log/Task3.log", replace 
	
	** SET BUILD AND ANALYSIS PATH
	global build	"Build/Code" 
	global analysis	"Analysis/Code"
	
	
	**** TASK 3
	* Construct dateset
	do "$build/DataConstruction.do"

	* Analysis
	do "$analysis/Analysis.do"
	

	
	*** END OF DO FILE ***
	
	log close 
