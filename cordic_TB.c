#include <stdio.h>
#include <math.h>
int main( void) {
	double x_d, y_d, z_d; /* 64-bit floating-point precision */
	int x_i, y_i, z_i; /* integer (fixed-point) variables */
	int i;

	x_d = 4.0;
	y_d = 1.0;
	z_d = atan( y_d / x_d) * 57.2958; /* call to std-C math routine */

	x_i = x_d * (1 << 20); /* convert to 20-bit integers */
	y_i = y_d * (1 << 20); /* convert to 20-bit integers */
	z_i = z_d * 57.2958 / (45.0)  * (1 << 15); /* convert a floating point degree to a integer in related to the scale factor used by elementary rotations */

	printf( "x_d = %f\t\t\tx_i = %i\n", x_d, x_i);
	printf( "y_d = %f\t\t\ty_i = %i\n", y_d, y_i);
	printf( "z_d = %f\t\t\tz_i = %i\n", z_d, z_i);
	printf( "\n");

	printf( "The angle table: (in degrees)\n");
	for( i=0; i<16; i++) {
		printf( "z[%2i] = %i\n", i, (int)( (atan( pow( 2.0, (double)(-i))) * 57.2958 / 45.0  * (1 << 15))) );
	}

}
