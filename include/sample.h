#ifndef SMAPLE_H
#define SMAPLE_H

typedef struct {
    int id;
    char name[50];
} Sample;

void add_sample(Sample* sample, int id, const char* name);
void print_sample(Sample* sample);

#endif  // !DEBUG
