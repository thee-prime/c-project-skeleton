#include <stdio.h>

#include "sample.h"

int main(void)
{
    Sample sample;
    add_sample(&sample, 1, "Test Sample");
    print_sample(&sample);

    return 0;
}
