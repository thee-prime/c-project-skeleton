#include "sample.h"

#include <stdio.h>

void add_sample(Sample* sample, int id, const char* name)
{
    sample->id = id;
    snprintf(sample->name, sizeof(sample->name), "%s", name);
}

void print_sample(Sample* sample)
{
    printf("Sample ID: %d, Name: %s\n", sample->id, sample->name);
}
