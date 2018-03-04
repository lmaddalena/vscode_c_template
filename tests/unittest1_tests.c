#include "test.h"

DEFINE_TEST(test1)
{

    test_assert(1==0, "not exhaustive test");
    
    return NULL;
}


DEFINE_TEST(all_tests)
{
    test_run(test1);

    return NULL;
}

TEST_SUITE(all_tests);