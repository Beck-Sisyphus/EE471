/*!flightTime.c
 *
 * This is a flight duration calculator that takes in a user requested flight
 * duration and calculates the estimated flight duration factoring headwind
 * and the requested time on aircraft.
 *
 * TABLE OF CONTENTS
 *
 * 1. getDuration(void) - Retrieves the user requested flight duration
 * 2. computVelocity(float,int) - Computes the estimated velocity and prints
 * 										 the estimated velocity 
 * 3. duration(int,float,float) - Computes estimated duration of flight
 * 										 factoring in headwind velocity and
 *											 total velocity
 * 4. displayResults(float) - Print estimated duration of flight
 *
 *
 * Created by AJ Townsend, Beck Pang, Raymond Mui
 */

//Standard C input/output libraries and int header files
#include <stdio.h>
#include <stdint.h>

#define  wind  89.6 // head wind velocity
#define  dist  4791 // distance from Seattle to London

//function prototypes
float getDuration(void);
float computeVelocity(float hours, int distance);
float duration(int distance, float velocity, float headWind);
void displayResults(float duration);

int main(void) {
	float retrDuration = getDuration();
	float velocity = computeVelocity(retrDuration, dist);
	float estimatedDuration = duration(dist, velocity, wind);
	displayResults(estimatedDuration);
 	return 0;
 }

//Prompts user for requested duration. While duration is invalid (less than or
//equal to zero, this function will keep prompting for a valid duration.
//Returns duration
float getDuration(void) {
 	printf("Enter duration of flight to London from Seattle in hours: \n");
 	float duration = 0.0;
 	scanf("%f", &duration);
	while (duration <= 0) {
		printf("Please enter a valid duration.\n");
		scanf("%f",&duration);
 	}
	return duration;
 }

// Calculates the estimated velocity and prints it
float computeVelocity(float hours, int distance) {
	float velocity  = distance / hours;
 	printf("Estimated Velocity: %f \n", velocity);
 	return velocity;
 }

// Calculates duration based off user input and headwind velocity. If the
// velocity is less than head wind, tell the user that they will not make
// their destination
float duration(int distance, float velocity, float headWind) {
	if(velocity < headWind) {
 		printf("You will not reach the destination.\n");
 		return 0.0;
 	}
	float totalVelocity = velocity - headWind;
	float estimatedDuration = distance / totalVelocity;
 	return estimatedDuration;
 }

// Prints estimated flight duration in hours
void displayResults(float duration) {
	printf("Estimated flight duration hours:  %f \n", duration);
 }



