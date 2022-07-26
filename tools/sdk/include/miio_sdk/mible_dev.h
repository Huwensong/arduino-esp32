#ifndef __MIBLE_DEV_H__
#define __MIBLE_DEV_H__

#include "mibeacon_def.h"
#include "miio_api.h"
#include "jsmi.h"
#include "list.h"
typedef struct {
    mibeacon_object_t  report;
    struct list_head list;
} mibeacon_object_list_t;

typedef struct {
    uint8_t mac[6];
    uint16_t pid;
    uint8_t token[MIBEACON_TOKEN_LEN];
    uint8_t did[MIBEACON_DID_LEN];
    uint8_t beaconkey[MIBEACON_BEACONKEY_LEN];
    uint8_t already_encrypted;
    uint32_t counter;
    uint32_t replay_counter;
    uint32_t ttl;
    uint8_t report_num;
    uint8_t spec_supported;
    mibeacon_object_list_t mibeacon_object_list;
    uint8_t mibeacon_object_list_count;
    //mibeacon_object_t report[MAX_OBJECT_ID_IN_PID];
} authed_dev_t;

typedef struct {
    uint8_t mac[6];
    uint16_t pid;
    uint32_t ttl;
} unknown_dev_t;

typedef struct {
    uint8_t mac[6];
    uint16_t pid;
    uint32_t ttl;
} denied_dev_t;
typedef struct {
    uint8_t mac[6];
    uint16_t pid;
} query_dev_t;

typedef struct {
    uint8_t mac[6];
    int8_t rssi;
} miband_dev_t;

int authed_dev_init(void);
int unknown_dev_init(void);
int denied_dev_init(void);
int miband_dev_init(void);

int authed_dev_add(authed_dev_t *p_dev);
int unknown_dev_add(unknown_dev_t *p_dev);
int denied_dev_add(denied_dev_t *p_dev);
int miband_dev_add(miband_dev_t *p_dev);

int authed_dev_delete(uint8_t *mac, uint16_t pid);
int unknown_dev_delete(uint8_t *mac, uint16_t pid);
int denied_dev_delete(uint8_t *mac, uint16_t pid);

authed_dev_t *authed_dev_search(uint8_t *mac, uint16_t pid);
unknown_dev_t *unknown_dev_search(uint8_t *mac, uint16_t pid);
denied_dev_t *denied_dev_search(uint8_t *mac, uint16_t pid);

int authed_dev_print(void);
int unknown_dev_print(void);
int denied_dev_print(void);

int authed_dev_decrease_ttl(void);
int unknown_dev_decrease_ttl(void);
int denied_dev_decrease_ttl(void);

bool authed_dev_checkfull(void);
bool unknown_dev_checkfull(void);

int mible_dev_rule_init(void);
int mibeacon_timer_init(void);
int mibeacon_timer_deinit(void);
//qurey dev list
int query_dev_init(void);
int query_dev_add(query_dev_t *p_dev);
int query_dev_delete(uint8_t *mac, uint16_t pid);
int query_dev_delete_all(void);
query_dev_t *query_dev_search(uint8_t *mac, uint16_t pid);
int query_dev_print(void);
int query_dev_get_string(jsmi_composer_t *composer);
//mibeceacon report
int auth_dev_mibeacon_report_add(authed_dev_t *p_dev,mibeacon_object_t *p_report);
mibeacon_object_t *auth_dev_mibeacon_report_search(authed_dev_t *p_dev,mibeacon_object_t *p_report);


int mible_dev_bind_action(uint8_t* addr, uint16_t pdid);
int mible_dev_unbind_action(uint8_t* addr, uint16_t pdid);

#endif
