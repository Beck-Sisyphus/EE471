#include <stdio.h>
#include <stdint.h>

float wind = 89.6;
int dist = 4791;

float getDuration();
float printVelocity(float hours, int dist);
float getEstimatedDuration(int dist, float velocity, float wind);
void printEstimatedDuration(float estimatedDuration);

int main() {
	float duration = getDuration();
	float velocity = printVelocity(duration, dist);
	float estimatedDuration = getEstimatedDuration(dist, velocity, wind);
	printEstimatedDuration(estimatedDuration);
	return 0;
}

float getDuration() {
	printf("Enter duration of flight to London from Seattle in hours: \n");
	float duration = 0.0;
	scanf("%f", &duration);
	return duration;
}

float printVelocity(float hours, int dist) {
	float velocity  = dist / hours;
	printf("Estimated Velocity: %f \n", velocity);
	return velocity;
}

float getEstimatedDuration(int dist, float velocity, float wind) {
	if(velocity < wind) {
		printf("will not reach destination\n");
		return 0.0;
	}
	float totalVelocity = velocity - wind;
	float estimatedDuration = dist / totalVelocity;
	return estimatedDuration;
}

void printEstimatedDuration(float estimatedDuration) {
	printf("Estimated flight duration is %f hours: \n", estimatedDuration);
}



