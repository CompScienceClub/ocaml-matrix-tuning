#include <malloc.h>

double *mult_sv(double s, double *x, int rows) {
    int    i;
    double *y;

    y = malloc(rows * sizeof(double));
    
    for (i = 0; i < rows; i++) {
        y[i] = s * x[i];
    }
    return y;
}
