// Beck Pang, University of Washington, Seattle
/*
1. Abstract
	We want to calculate my income after tax

2. Introduction
	This program calculate your net income after turing social security, 
	federal tax, and state tax. 

3. Inputs
	User's salary 
	state income rate
4. Outputs
	print out step by step the amount you turn in to social security,
	federal tax, and state tax

5. Major functions
		income before tax
	-   social security rate * income
	=   income after SS
	-	federal tax rate * income after SS
	=	income after federal tax
	-	state tax rate * income after federal tax
	= 	income after tax
*/

// preprocessor directive to support printing to the display
#include <stdio.h>

int main(void)
{
	// declare, define, and initialize some working variables
	// inputs
	float incomeBeforeTax    = 0.0;
	float stateTaxRate       = 0.0;

	// constant
	int   socialSecurityLine = 65000;
	float socialSecurityRate = 10.3;
	int   federalTaxMin      = 3500;
	int   federalTaxLine     = 30000;
	float federalTaxRate     = 28.0;
	// #define socialSecurityLine = 65000;
	// #define socialSecurityRate = 10.3;
	// #define federalTax         = 3500;
	// #define federalTaxLine     = 30000;
	// #define federalTaxRate     = 28.0;

	// intermediates
	float socialSecurity     = 0.0;
	float incomeAfterSS      = 0.0;
	float federalTax         = 0.0;
	float incomeAfterFedTax  = 0.0;
	float stateTax           = 0.0;
	// float incomeAfterState   = 0.0;
	// output
	float netIncome          = 0.0;

	// ask the user for salary 
	printf("Please enter your salary:\n");

	// get the data from the user
	// the data will be a floating point number: %f
	// stored in the variable 'incomeBeforeTax'
	// the & operator takes the address of the variable
	scanf("%f", &incomeBeforeTax);

	// remove newline from input butter
	getchar();

	// ask the user for state tax rate
	printf("Please enter your state tax rate (as a percentage):\n");
	scanf("%f", &stateTaxRate);
	getchar();

	// print the salary and state tax rate
	// with the format of xx.yy
	printf("Your income before tax is $%.2f,and your state tax rate is %.2f %% \n",incomeBeforeTax, stateTaxRate);

	if (incomeBeforeTax < socialSecurityLine) {
		socialSecurity = incomeBeforeTax * socialSecurityRate;
	}	else {
		socialSecurity = socialSecurityRate * socialSecurityLine;
	}
	incomeAfterSS = incomeBeforeTax - socialSecurity; 

	printf("Your Social Security costs you $%.2f.\n", socialSecurity);

	if (incomeAfterSS < federalTaxLine) {
		federalTax = federalTaxMin;
	}	else {
		federalTax = federalTaxMin + (incomeAfterSS - federalTaxLine) * federalTaxRate;
	}
	incomeAfterFedTax = incomeAfterSS - federalTax;

	printf("Your need to pay $%.2f for federal tax.\n", federalTax);

	stateTax = incomeAfterFedTax * stateTaxRate;

	printf("Your need to pay $%.2f for state tax.\n", stateTax);

	netIncome = incomeAfterFedTax - stateTax;

	printf("Your net income after tax is $%.2f.\n", netIncome);

	return 0;
}
