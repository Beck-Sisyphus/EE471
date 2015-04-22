#include <stdio.h>
#include <stdint.h>

float headWind = 89.6;
int distance = 4791;

float getDuration(void);
float computeVelocity(float hours, int dist);
float duration(int distance, float velocity, float headWind);
void displayResults(float duration);

int main(void) {
	float retrDuration = getDuration();
	float velocity = computeVelocity(retrDuration, distance);
	float estimatedDuration = duration(distance, velocity, headWind);
	displayResults(estimatedDuration);
	return 0;
}

float getDuration(void) {
	printf("Enter duration of flight to London from Seattle in hours: \n");
	float duration = 0.0;
	scanf("%f", &duration);
	while(duration <= 0) {
		printf("The duration that you entered is invalid. Please enter a value greater than 0.\n");
		printf("Enter duration of flight to London from Seattle in hours:\n");
		scanf("%f",&duration);
	}
	return duration;
}

float computeVelocity(float hours, int distance) {
	float velocity  = distance / hours;
	printf("Estimated Velocity: %f \n", velocity);
	return velocity;
}

float duration(int distance, float velocity, float headWind) {
	if(velocity < headWind) {
		printf("You will not reach the destination.\n");
		return 0.0;
	}
	float totalVelocity = velocity - headWind;
	float estimatedDuration = distance / totalVelocity;
	return estimatedDuration;
}

void displayResults(float duration) {
	printf("Estimated flight duration hours:  %f \n", duration);
}



