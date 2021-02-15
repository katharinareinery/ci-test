#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include <aes.h>
#include <unity.h>

struct AES_ctx* ctx;

void setUp(void)
{
    ctx = malloc(sizeof(struct AES_ctx));
}

void tearDown(void)
{
    free(ctx);
}

void test_encrypt128(void)
{
    // clang-format off
    uint8_t input[16] = {
        0x01, 0x11, 0x22, 0x33,
        0x44, 0x55, 0x66, 0x77,
        0x88, 0x98, 0xaa, 0xbb,
        0xcc, 0xdd, 0xee, 0xff
    };
    uint8_t key[16] = {
        0x00, 0x01, 0x02, 0x03,
        0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x01, 0x0b,
        0x0c, 0x0d, 0x0e, 0x0f
    };
    uint8_t expects[16] = {
        0x69, 0xc4, 0xe0, 0xd8,
        0x6a, 0x7b, 0x04, 0x30,
        0xd8, 0xcd, 0xc7, 0x80,
        0x70, 0xb4, 0xc5, 0x5a
    };
    // clang-format on
    AES_init_ctx(ctx, key);
    AES_ECB_encrypt(ctx, input);
    TEST_ASSERT_EQUAL_HEX8_ARRAY(expected, input, sizeof(input));
}

int main(void)
{
    UNITY_BEGIN();

    // Simulate a longer test run-time
    sleep(15);

    RUN_TEST(test_encrypt128);

    return UNITY_END();
}
