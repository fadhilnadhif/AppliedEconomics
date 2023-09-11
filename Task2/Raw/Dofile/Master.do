* ==============================================================================
*
* Title				: Task 2 Applied Empirical Economics 
* Aim				: Master Do File 
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 4th, 2023
*
* ==============================================================================

	** INITIALIZATION
	set more off
	clear all
	
	** SET GLOBAL DIRECTORY PATH
	if `"`c(os)'"' == "MacOSX"   global path = "/Users/nadhif/Desktop/AppliedEconomics/Task2"
	cd "$path"
	
	** LOG FILE
	log using "Communications/Logs/Task2.log", replace 
	
	** SET BUILD AND ANALYSIS PATH
	global build	"Build/Dofile" 
	global analysis	"Analysis/Dofile"
	
	
	**** TASK 2A
	* Normalize dateset
	do "$build/DataConstruction.do"
	* Install the program
	do "$build/Programs.do"
	* Value review
	do "$analysis/ValueReview.do"
	
	**** TASK 2B
	do "$analysis/AK91Tables.do"
	
	
	*** END OF DO FILE ***
	
	log close 
