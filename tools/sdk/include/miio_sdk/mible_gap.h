/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MIBLE_GAP_H__
#define __MIBLE_GAP_H__

/* Includes ------------------------------------------------------------------*/

#include "mible_def.h"

/* Exported types ------------------------------------------------------------*/

typedef struct {
    mible_addr_t address;
    uint8_t len;
    uint8_t data[31];
    int8_t rssi;
} mible_beacon_t;

typedef struct {
    mible_addr_t address;
    uint16_t step;
    uint8_t sleep;
    int8_t rssi;
    uint32_t ext_data;
} mible_band_t;

typedef enum {
    MIBLE_LOCAL_ROLE_MASTER,
    MIBLE_LOCAL_ROLE_SLAVE,
} mible_local_role_t;

typedef struct {
    mible_addr_t address;
    uint16_t conn_handle;
    mible_local_role_t local_role;
} mible_connect_t;

typedef struct {
    uint16_t conn_handle;
    uint8_t reason;
} mible_disconnect_t;

/* Exported constants --------------------------------------------------------*/

#define MIBLE_EVT_GAP_BEACON                          MIBLE_EVT_GAP_PERUSER + 0
#define MIBLE_EVT_GAP_BAND                            MIBLE_EVT_GAP_PERUSER + 1
#define MIBLE_EVT_GAP_CONNECT                         MIBLE_EVT_GAP_PERUSER + 2
#define MIBLE_EVT_GAP_DISCONNECT                      MIBLE_EVT_GAP_PERUSER + 3

#define MIBEACON_ITEM_SEC_ENABLE                      0x0008
#define MIBEACON_ITEM_MAC_INCLUDE                     0x0010
#define MIBEACON_ITEM_CAP_INCLUDE                     0x0020
#define MIBEACON_ITEM_EVT_INCLUDE                     0x0040

#define MIBEACON_CAP_CONNECTABLE                      0x01
#define MIBEACON_CAP_ENCRYPTABLE                      0x04
#define MIBEACON_CAP_TYPE_COMBO                       (0x03 << 3)

#define MIBEACON_VERSION                              (0x0005 << 12)
#define MIBEACON_AUTH_MODE                            (0x0002 << 10)

#define MIBEACON_CHECK_PERIOD                         1000
#define MIBLE_GAP_SCAN_DELAY                          6000

#define HI_UINT16(a)                                  (((a) >> 8) & 0xFF)
#define LO_UINT16(a)                                  ((a) & 0xFF)

#define MIBLE_DISCONN_REASON_FAIL_ESTABLISH           0x3e


/* Exported functions --------------------------------------------------------*/

int mible_gap_init(void);
int mible_gap_deinit(void);
int mible_beacon_start(void);
int mible_beacon_stop(void);
int mible_connect_handler(mible_connect_t *p_connect);
int mible_disconnect_handler(mible_disconnect_t *p_disconnect);
mible_connect_t * mible_find_connection_by_handle(uint16_t conn_handle);
mible_connect_t * mible_find_connection_by_address(mible_addr_t address);
int mible_gap_scan(bool enable);
int start_delay_scan_timer(void);

#endif
