* ==============================================================================
*
* Title				: AK 1991 and AL 1999 Data Cleaning Task
* Aim				: Value Review
* Modified by		: Fadhil Nadhif Muharam
* Stata version  	: 17
* Last modified  	: September 4th, 2023
*
* ==============================================================================

	** INITIALIZATION
	set more off
	clear all

	** SET GLOBAL DIRECTORY PATH
	cd "$path"
	// Note: I set global directory path here instead of the master do file 
	// to ease replicator to replicate individual tables separately
	
	** SET INPUT AND OUTPUT PATH
	global inputpath	"Analysis/Data" 
	global outputpath	"Analysis/Results"
	
	** INITIALLIZE PROGRAM
	do "Build/Dofile/Programs.do"
	
	** VALUE REVIEW USING PROGRAM
	valuereview using "$inputpath/AK91_Data.dta", numericfile("$outputpath/AK91_ValueReview.tex")
	valuereview using "$inputpath/AL99_Grade4_Data.dta", numericfile("$outputpath/AL99_Grade4_ValueReview.tex")
	valuereview using "$inputpath/AL99_Grade5_Data.dta", numericfile("$outputpath/AL99_Grade5_ValueReview.tex")
	
	*** END OF DO FILE ***

	
	