#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define BIT_ROT 20
#define DIV_FLOAT 1048576.0
#define DIV_INT 1048576

#define SCALE_CONSTANT 0.60725

#define ELEM_SIZE 27

/*
 * The elementary angles in a lookup table. They correspond to
 * arctan(2^-i) and then shifted left by 20 bits in an integer format
 * for example: 45 = 47185920 / (1 << 20)
 */
int elem_angle[] = {47185920, 27855475, 14718068, 7471121, 3750058, 1876857, 938658, 469357, 234682, 117342,
					58671, 29335, 14668, 7334, 3667, 1833, 917, 458, 229, 115, 57, 29, 14, 7, 4, 2, 1};

typedef struct vector3 {
	int x;
	int y;
	int z;
}VEC, *P_VEC;

typedef enum {ROTATION, VECTOR} cordic_mode_t;

typedef enum {NEG, POS} cordic_decision;

// Convert Fixed/Float to Float/Fixed
double fixed_to_float(int fixed)
{
	return fixed / DIV_FLOAT;
}

int float_to_fixed(double flt)
{
	return (int)(flt * DIV_INT);
}

/*
 * To reduce if operations by deciding which mode the program is willing to run before actually running
 */
cordic_decision rot_decision(cordic_mode_t mode, int val)
{
	return ROTATION == mode && val < 0 || ROTATION != mode && val > 0 ? POS : NEG;
}


/*
 * rotation mode
 * x,y are coordinates of vector.
 * z is the accumulator of the angle. z will approach 0 after 27 iterations.
 * 
 * vector mode
 * x,y are coordinates of vector. y will approach 0 after 27 iterations.
 * z is the accumulator of the angle. It will approach z[0] + arctan(y[0]/x[0]) after 27 iterations.
 */ 
void cordic(P_VEC v, cordic_mode_t mode)
{
	int i;
	int x_temp;
	int* nVal;

	// use a pointer so that it checks the right value in rot_decision.
	if (mode == ROTATION)
	{
		nVal = &(v->z);
	} else {
		nVal = &(v->y);
	}
	
	v->x = v->x << BIT_ROT;
	v->y = v->y << BIT_ROT;
	v->z = v->z << BIT_ROT;
	
	for (i = 0; i < ELEM_SIZE; i++)
	{
		x_temp = v->x;
		if (POS == rot_decision(mode, *nVal))
		{
			v->x = v->x + (v->y >> i);
			v->y = v->y - (x_temp >> i);
			v->z = v->z + elem_angle[i]; 
		} else {
			v->x = v->x - (v->y >> i);
			v->y = v->y + (x_temp >> i);
			v->z = v->z - elem_angle[i];
		}
	}
}

//get cos(theta) using cordic algorithm
double cos_cordic(int theta)
{
	VEC v = {1, 0, theta};
	cordic(&v, ROTATION);
	return fixed_to_float(v.x * SCALE_CONSTANT);
}

//get sin(theta) using cordic algorithm
double sin_cordic(int theta)
{
	VEC v = {1, 0, theta};
	cordic(&v, ROTATION);
	return fixed_to_float(v.y * SCALE_CONSTANT);
}

//get arctan(y/x) using cordic algorithm
double arctan_div_cordic(int y, int x)
{
	VEC v = {x, y, 0};
	cordic(&v, VECTOR);
	return fixed_to_float(v.z);
}

//get arctan(y) using cordic algorithm
double arctan_cordic(int y)
{
	VEC v = {1, y, 0};
	cordic(&v, VECTOR);
	return fixed_to_float(v.z);
}
/*
		Used for testing performance
		test = cos_cordic(1.0);
		test = cos_cordic(20.0);
		test = cos_cordic(30.0);
		test = cos_cordic(45.0);
		test = sin_cordic(40.0);
		test = sin_cordic(90.0);
		test = arctan_div_cordic(1.0, 4.0);
		test = arctan_div_cordic(1.0, 2.0);
		test = arctan_div_cordic(1.0, 6.0);
		test = arctan_cordic(1.0);
		test = arctan_cordic(2.0);
		test = arctan_cordic(3.0);
*/
int main()
{
	clock_t start = clock();
	int i;
	double test = 0;
	for(i = 0; i < 256; i++){
		printf("Cos(1): %.8lf\n", cos_cordic(1.0));
		printf("Cos(20): %.8lf\n", cos_cordic(20.0));
		printf("Cos(30): %.8lf\n", cos_cordic(30.0));
		printf("Cos(45): %.8lf\n", cos_cordic(45.0));
		printf("Sin(40): %.8lf\n", sin_cordic(40.0));
		printf("Sin(90): %.8lf\n", sin_cordic(90.0));
		printf("Arctan(1/4): %.8lf\n", arctan_div_cordic(1.0, 4.0));
		printf("Arctan(1/2): %.8lf\n", arctan_div_cordic(1.0, 2.0));
		printf("Arctan(1/6): %.8lf\n", arctan_div_cordic(1.0, 6.0));
		printf("Arctan(1): %.8lf\n", arctan_cordic(1.0));
		printf("Arctan(2): %.8lf\n", arctan_cordic(2.0));
		printf("Arctan(3): %.8lf\n", arctan_cordic(3.0));
	}
	clock_t end = clock();
	printf("Final result: %f\n", test);
	printf("running time: %f\n", (double)(end - start) / CLOCKS_PER_SEC);
	return 0;
}
