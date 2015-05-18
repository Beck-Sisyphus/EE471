#include <stdio.h>
#include <stdlib.h>

int main() {
    // initialize variables
    int A = 25;
    int B = 16;
    int C = 7;
    int D = 4;
    int E = 9;

    // declare pointers and let each refer to the address corresponding variable
    int *ptrA = &A;
    int *ptrB = &B;
    int *ptrC = &C;
    int *ptrD = &D;
    int *ptrE = &E;

    // perform computation using the pointers
    int result1 = ((*ptrA - *ptrB) * (*ptrC + *ptrD)) / *ptrE;

    // print the result
    printf("%d",result1);

    return 0;
}

void practice() {    
    // Declare two variables of type int, two variables of type float,
    // and two variables of type char. 
    int a = 1;
    int b = 4;
    float c = 3.4;
    float d = 7.2;
    char e = 'e';
    char f = 'f';

    // Declare one pointer to int, one pointer to float, and one
    // pointer to char.
    int* ptrA;
    float* ptrB;
    char* ptrC;

    // Assign the address of one of the integer variables to the pointer to int.
    ptrA = &a;

    // Print out the value of that integer.
    printf("%d", *ptrA);

    // Repeat with the second integer.
    ptrA = &b;
    printf("%d", *ptrA);

    // Repeat with the two floats.
    ptrB = &c;
    printf("%f", *ptrB);
    ptrB = &d;
    printf("%f", *ptrB);

    // Repeat with the two chars.
    ptrC = &e;
    printf("%c", *ptrC);
    ptrC = &f;
    printf("%c", *ptrC);

}