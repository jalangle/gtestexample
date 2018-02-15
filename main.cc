#include <gtest/gtest.h>


TEST(ExampleTest, Successs) {
	EXPECT_EQ(0, 0);
}

TEST(ExampleTest, Failure) {
	EXPECT_EQ(0, 1);
}