/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FAST_PAIR_H__
#define __FAST_PAIR_H__

/* Includes ------------------------------------------------------------------*/

#include <stdint.h>
#include <stdbool.h>
#include "mible_def.h"

/* Private typedef -----------------------------------------------------------*/

typedef enum {
    FASTPAIR_STATE_SUCC,
    FASTPAIR_STATE_FAIL,
    FASTPAIR_STATE_TIMEOUT,
    FASTPAIR_STATE_EXISTED,
} fastpair_state_t;

typedef enum {
    FASTPAIR_IDLE,
    FASTPAIR_RECEIVED_PKT,
    FASTPAIR_REPORT_CHECK_TO_MCU,
    FASTPAIR_GET_DOWN_REPORT,
    FASTPAIR_MCU_SET_PERMIT,
    FASTPAIR_PAIR_START,
    FASTPAIR_CONNECTED,
    FASTPAIR_PAIR_SUCC,
    FASTPAIR_KEY_SAVED,
    FASTPAIR_REPORT_RESULT_TO_MCU,
} fastpair_process_status_t;

typedef enum {
    ERROR_NONE,
    ERROR_NO_MEM,
    ERROR_CMD_PUT,
    ERROR_SCAN_OFF,
    ERROR_CONNECT_START,
    ERROR_CONNECT_FAILED,
    ERROR_GATTC_GET_SERVICE_FAILED,
    ERROR_DISCONNECTED,
    ERROR_VARIFY_FAILED,
    ERROR_KEY_SAVE_FAILED
} fastpair_fail_reason_t;

extern uint8_t fastpair_status;
extern uint8_t fastpair_errcode;

/* Exported functions --------------------------------------------------------*/

int mible_fastpair_init(void);
int mible_fastpair_start(mible_addr_t address, uint16_t product_id,
                            uint16_t object_id, int8_t rssi);
uint16_t mible_fastpair_get_pid(void);
int mible_fastpair_complete(uint16_t conn_handle, uint8_t *p_key, bool isSecureFastpair);
int mible_fastpair_update(mible_addr_t address, uint16_t product_id,
                            uint16_t object_id, bool permit);
int mible_fastpair_refresh(void);
int mible_fastpair_retry();

#endif
