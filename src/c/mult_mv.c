#include <malloc.h>

double *mult_mv(double **A, double *x, int rows, int cols) {
    int    i, j;
    double s;
    double *Ai, *y;

    Ai = malloc(cols * sizeof(double));
    y  = malloc(cols * sizeof(double));

    for (i = 0; i < cols; i++) {
        s  = 0.0;
        Ai = A[i]; 
        for (j = 0; j < rows; j++) {
            s += Ai[j] * x[j];
        }
        y[i] = s; 
    }
    free(Ai);
    return y;
}
