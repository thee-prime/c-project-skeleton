#include <assert.h>
#include <stdio.h>
#include <string.h>

#include "sample.h"

static void test_add_sample_sets_fields(void)
{
    Sample sample = {0};

    add_sample(&sample, 42, "Unit Test");

    assert(sample.id == 42);
    assert(strcmp(sample.name, "Unit Test") == 0);
}

static void test_add_sample_truncates_long_name(void)
{
    Sample sample = {0};
    const char* long_name =
        "This string is intentionally longer than fifty characters to test truncation.";

    add_sample(&sample, 7, long_name);

    assert(sample.id == 7);
    assert(strncmp(sample.name, long_name, sizeof(sample.name) - 1) == 0);
    assert(sample.name[sizeof(sample.name) - 1] == '\0');
}

int main(void)
{
    printf("Running sample tests...\n");
    test_add_sample_sets_fields();
    test_add_sample_truncates_long_name();
    puts("All sample tests passed.");
    return 0;
}
