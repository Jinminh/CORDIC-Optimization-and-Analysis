#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define DIV_FLOAT 1048576.0
#define DIV_INT 1048576
#define DIV_FLOAT_ANGLE 32768.0
#define DIV_INT_ANGLE 32768

#define SCALE_CONSTANT 0.607252935 //636748 //0.60725 * 1048576

#define ELEM_SIZE 16

typedef struct vector_x_y{
	int x;
	int y;
} VEC_X_Y;


inline double fixed_to_float(int fixed)
{
	return fixed / DIV_FLOAT;
}
inline double angle_fixed_to_float(int fixed)
{
	return (fixed / DIV_FLOAT_ANGLE) * 45.0;
}

// Convert Fixed/Float to Float/Fixed
inline int float_to_fixed(double flt)
{
	return (int)(flt * DIV_INT);
}
inline int angle_float_to_fixed(double flt)
{
	return (int)((flt / 45.0) * DIV_INT_ANGLE);
	
}

/*
 * x,y are coordinates of vector.
 * z is the accumulator of the angle. z will approach 0 after 16 iterations.
 */ 
VEC_X_Y cordic_rotation(register int x, register int y, register int z)
{
	//use register specifier.
	register int x_temp;
	register int i;
	//use local variables instead of global variable
	//45 is represented by 2^15
	//short elem_angle_original[] = { 32768, 19344, 10221, 5188, 2604, 1303, 652, 326, 163, 81, 41, 20, 10, 5, 3, 1};
	unsigned int angle_holder;
	unsigned int angle_left;
	unsigned int angle_right;
	register int angle_counter = 0;
	//packed two angles into one element.
	unsigned int elem_angle[] = {2147502992, 669848644, 170657047, 42729798, 10682449, 2686996, 655365, 196609};
	//unroll the for loop manually, and software pipelining.
	angle_holder = elem_angle[angle_counter];
	angle_counter ++;
	for (i = 0; i != ELEM_SIZE - 4;)
	{
		x_temp = x;
		angle_left = (angle_holder >> 16);
		angle_right = (angle_holder & 0x0000FFFF);
		angle_holder = elem_angle[angle_counter];
		angle_counter ++;
		if (z < 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_left; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_left;
		}
		x_temp = x;
		i++;
		if (z < 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_right; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_right;
		}
		x_temp = x;
		i++;
		angle_left = (angle_holder >> 16);
		angle_right = (angle_holder & 0x0000FFFF);
		angle_holder = elem_angle[angle_counter];
		angle_counter++;
		if (z < 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_left; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_left;
		}
		x_temp = x;
		i++;
		if (z < 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_right; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_right; 
		}
		//angle_counter++;
		i++;
	}

	x_temp = x;
	angle_left = (angle_holder >> 16);
	angle_right = (angle_holder & 0x0000FFFF);
	angle_holder = elem_angle[angle_counter];
	angle_counter ++;
	if (z < 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_left; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_left;
	}
	x_temp = x;
	i++;
	if (z < 0)
		{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_right; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_right;
	}
	x_temp = x;
	i++;
	angle_left = (angle_holder >> 16);
	angle_right = (angle_holder & 0x0000FFFF);
	if (z < 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_left; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_left;
	}
	x_temp = x;
	i++;
	if (z < 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_right; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_right; 
	}

	VEC_X_Y result = {x, y};
	return result;
}

/*
 * x,y are coordinates of vector. y will approach 0 after 16 iterations.
 * z is the accumulator of the angle. It will approach z[0] + arctan(y[0]/x[0]) after 16 iterations.
 */ 
int cordic_vector(register int y, register int x, register int z)
{
	//use register specifier.
	register int x_temp;
	register int i;

	unsigned int angle_holder;
	unsigned int angle_left;
	unsigned int angle_right;
	register int angle_counter = 0;
	//packed two angles into one element.
	unsigned int elem_angle[] = {2147502992, 669848644, 170657047, 42729798, 10682449, 2686996, 655365, 196609};
	angle_holder = elem_angle[angle_counter];
	angle_counter ++;
	//unroll the for loop manually, and software pipelining.
	for (i = 0; i != ELEM_SIZE - 4;)
	{
		x_temp = x;
		angle_left = (angle_holder >> 16);
		angle_right = (angle_holder & 0x0000FFFF);
		angle_holder = elem_angle[angle_counter];
		angle_counter ++;
		if (y >= 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_left; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_left;
		}
		i++;
		x_temp = x;
		if (y >= 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_right; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_right; 
		}
		i++;
		x_temp = x;
		angle_left = (angle_holder >> 16);
		angle_right = (angle_holder & 0x0000FFFF);
		angle_holder = elem_angle[angle_counter];
		angle_counter ++;

		if (y >= 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_left;
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_left;
		}
		x_temp = x;		
		i++;
		if (y >= 0)
		{
			x = x + (y >> i);
			y = y - (x_temp >> i);
			z = z + angle_right; 
		} else {
			x = x - (y >> i);
			y = y + (x_temp >> i);
			z = z - angle_right; 
		}
		i++;
	}
	x_temp = x;
	angle_left = (angle_holder >> 16);
	angle_right = (angle_holder & 0x0000FFFF);
	angle_holder = elem_angle[angle_counter];
	angle_counter ++;
	if (y >= 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_left; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_left;
	}
	i++;
	x_temp = x;
	if (y >= 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_right; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_right; 
	}
	i++;
	x_temp = x;
	angle_left = (angle_holder >> 16);
	angle_right = (angle_holder & 0x0000FFFF);

	if (y >= 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_left;
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_left;
	}
	i++;
	x_temp = x;	
	if (y >= 0)
	{
		x = x + (y >> i);
		y = y - (x_temp >> i);
		z = z + angle_right; 
	} else {
		x = x - (y >> i);
		y = y + (x_temp >> i);
		z = z - angle_right; 
	}

	return z;
}

//get the result of cos(theta) using cordic algorithm
float cos_cordic(float theta)
{
	int i_theta = angle_float_to_fixed(theta);
	VEC_X_Y vec_res = cordic_rotation(DIV_INT, 0, i_theta);
	return fixed_to_float(vec_res.x) * SCALE_CONSTANT;
}

//get the result of sin(theta) using cordic algorithm
float sin_cordic(float theta)
{
	int i_theta = angle_float_to_fixed(theta);
	VEC_X_Y vec_res = cordic_rotation(DIV_INT, 0, i_theta);
	return fixed_to_float(vec_res.y) * SCALE_CONSTANT;
}

//get the result of arctan(y/x) using cordic algorithm
float arctan_div_cordic(float y, float x)
{
	int i_x = float_to_fixed(x);
	int i_y = float_to_fixed(y);
	return angle_fixed_to_float(cordic_vector(i_y, i_x, 0));
}

//get the result of arctan(y) using cordic algorithm
float arctan_cordic(float y)
{
	int i_y = float_to_fixed(y);
	return angle_fixed_to_float(cordic_vector(i_y, DIV_INT, 0));
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
