//
// Created by Gordon on 2024/11/28.
//

#ifndef IVY2_0__MBEDTLS_H
#define IVY2_0__MBEDTLS_H

#define MBEDTLS_SSL_MAX_MAJOR_VERSION           3
#define MBEDTLS_SSL_MAX_MINOR_VERSION           3
#define MBEDTLS_SSL_MINOR_VERSION_0             0   /*!< SSL v3.0 */
#define MBEDTLS_SSL_MINOR_VERSION_1             1   /*!< TLS v1.0 */
#define MBEDTLS_SSL_MINOR_VERSION_2             2   /*!< TLS v1.1 */

#define MBEDTLS_SSL_MIN_MAJOR_VERSION           MBEDTLS_SSL_MAJOR_VERSION_3
#define MBEDTLS_SSL_MIN_VALID_MAJOR_VERSION MBEDTLS_SSL_MAJOR_VERSION_3
#define MBEDTLS_SSL_MIN_MINOR_VERSION           MBEDTLS_SSL_MINOR_VERSION_1
#define MBEDTLS_SSL_MIN_VALID_MINOR_VERSION MBEDTLS_SSL_MINOR_VERSION_1


#define MBEDTLS_SSL_HEADER_LEN 13
#define MBEDTLS_SSL_COMPRESSION_ADD          1024
#define MBEDTLS_SSL_MAC_ADD                 48  /* SHA-384 used for HMAC */
#define MBEDTLS_SSL_PADDING_ADD            256
#define MBEDTLS_SSL_PAYLOAD_OVERHEAD ( MBEDTLS_SSL_COMPRESSION_ADD +    \
                                       MBEDTLS_MAX_IV_LENGTH +          \
                                       MBEDTLS_SSL_MAC_ADD +            \
                                       MBEDTLS_SSL_PADDING_ADD          \
                                       )
#define MBEDTLS_SSL_IN_PAYLOAD_LEN ( MBEDTLS_SSL_PAYLOAD_OVERHEAD + \
                                     ( MBEDTLS_SSL_IN_CONTENT_LEN ) )
#define MBEDTLS_SSL_IN_BUFFER_LEN  \
    ( ( MBEDTLS_SSL_HEADER_LEN ) + ( MBEDTLS_SSL_IN_PAYLOAD_LEN ) )

#if defined(MBEDTLS_ECP_C)
static mbedtls_ecp_group_id ssl_preset_suiteb_curves[] = {
#if defined(MBEDTLS_ECP_DP_SECP256R1_ENABLED)
    MBEDTLS_ECP_DP_SECP256R1,
#endif
#if defined(MBEDTLS_ECP_DP_SECP384R1_ENABLED)
    MBEDTLS_ECP_DP_SECP384R1,
#endif
    MBEDTLS_ECP_DP_NONE
};
#endif

#endif //IVY2_0__MBEDTLS_H
