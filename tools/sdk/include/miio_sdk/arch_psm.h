#ifndef __ARCH_PSM_H__
#define __ARCH_PSM_H__

#include "arch_chip.h"


typedef enum{
    MIIO_KVEVT_NONE = 0,
    MIIO_KVEVT_NO_ENC,
    MIIO_KVEVT_NO_ORG,
    MIIO_KVEVT_DIFF,
    MIIO_KVEVT_RD_RM_ORG,
    MIIO_KVEVT_WT_RM_ORG,
} miio_kv_evt_type_t;

#define KV_EVTSTR_NO_ENC        "no_enc"
#define KV_EVTSTR_NO_ORG        "no_org"
#define KV_EVTSTR_DIFF          "diff_val"
#define KV_EVTSTR_RD_RM_ORG     "rd_rm_org"
#define KV_EVTSTR_WT_RM_ORG     "wt_rm_org"


#if MIIO_KV_STAT_REPORT_ENABLE

#define MIIO_KV_RECORD_VER      1
#define KV_RECORD_HEADER_LEN    4
#define KV_RECORD_VER_INDEX     0
#define KV_RECORD_SAV_INDEX     1
#define KV_RECORD_NUM_INDEX     3

typedef struct {
    uint8_t enckv_id;
    uint8_t evt_counts;
    int32_t last_errcode;
} __attribute__ ((__packed__))  miio_kv_evt_info_t;

typedef struct {
    miio_kv_evt_type_t etype;
    miio_kv_evt_info_t* einfo_list;
    uint8_t einfo_num;
    bool save_orignal;
} miio_kv_evt_record_t;

int psm_fill_kname_by_kvid(uint8_t kv_id, char* kname, uint8_t klen);
char* psm_get_kv_evtstr(miio_kv_evt_type_t etype);
int psm_dump_kvevt_records(miio_kv_evt_record_t** out_kerecords, uint16_t buff_len);
void psm_clear_kvevt_records();

#endif


#if MIIO_KV_ENCRYPT_ENABLE

#define MIIO_ENC_KNAME_MAX_LEN      64
#define MIIO_ENC_VALUE_MAX_LEN      512

int arch_psm_sync_encrypted_value(void);

#else

#define arch_psm_sync_encrypted_value()

#endif


int arch_psm_init(void);
int arch_psm_erase_key(const char* name_space, const char* key);
int arch_psm_erase_country_domain(const char* key);
int arch_psm_get_value(const char* name_space, const char* key, void *value, size_t length);
int arch_psm_set_value(const char* name_space, const char* key, const void* value, size_t length);
int arch_psm_get_str(const char* name_space, const char* key, char *str, size_t str_size);
int arch_psm_get_country_domain(const char* key, char *str, size_t str_size);
int arch_psm_set_str(const char* name_space, const char* key, const char* str);
int arch_psm_set_country_domain(const char* key, char *str);
int arch_psm_get_value_withmalloc(const char* name_space, const char* key, uint8_t **out_value);




#endif /* __ARCH_PSM_H__ */

