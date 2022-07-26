#ifndef __SPEC_RULE_H__
#define __SPEC_RULE_H__

#include <stdint.h>

#include "mibeacon_def.h"
#include "mible_dev.h"
#include "list.h"

typedef enum {
    SPEC_RULE_DATA_INVALID = 0,
    SPEC_RULE_DATA_BOOL,
    SPEC_RULE_DATA_INT8,
    SPEC_RULE_DATA_INT16,
    SPEC_RULE_DATA_INT32,
    SPEC_RULE_DATA_UINT8,
    SPEC_RULE_DATA_UINT16,
    SPEC_RULE_DATA_UINT32,
    SPEC_RULE_DATA_FLOAT,
    SPEC_RULE_DATA_STRING,
    SPEC_RULE_EVENT_OPMETHOD = 0x80,
    SPEC_RULE_EVENT_OPID,
    SPEC_RULE_EVENT_CURRTIME,
} spec_rule_data_t;

typedef enum {
    SPEC_EVENT_TYPE_NORMAL,
    SPEC_EVENT_TYPE_LOCK,           //hard code
    SPEC_EVENT_TYPE_INVALID,
} spec_event_type_t;

typedef union {
    struct{
        uint16_t piid : 9;
        uint16_t flag : 1;
        uint16_t siid : 4;
        uint16_t head : 2;
    }prop;
    struct{
        uint16_t eiid : 9;
        uint16_t flag : 1;
        uint16_t siid : 4;
        uint16_t head : 2;
    }event;
    uint16_t all;
} spec_id_v2_t;

typedef union {
    struct {
        uint8_t piid;
        uint8_t siid;               //Service ID is in big endian
    }prop;
    struct {
        uint8_t eiid : 7;
        uint8_t eiid_flag : 1;      //bit 7 is event flag
        uint8_t siid : 7;
        uint8_t lock_event_flag : 1;//Service ID is in big endian ,bit 7 is lock event flag
    }event;
    uint16_t all;
} spec_id_t;

// for properties
typedef struct {
    spec_id_v2_t spec_id;
    spec_rule_data_t type;
    uint32_t interval;
    uint32_t delta;
} spec_rule_t;

typedef struct {
    spec_rule_t rule;
    struct list_head list;
} spec_rule_list_t;

//for events
typedef struct {
    uint16_t piid;
    spec_rule_data_t type;
} spec_event_piid_t;

typedef struct {
    spec_id_v2_t spec_id;
    spec_event_piid_t event_piids[3];   //now 3 piid in one event ; up to 7 piid in one event for Multi-packet sending event
    uint8_t  piids_count;
    uint32_t interval;
    uint32_t delta;                     //not used
} spec_event_rule_t;

typedef struct {
    spec_event_rule_t rule;
    struct list_head list;
} spec_event_rule_list_t;


typedef struct {
    uint16_t pid;
    uint8_t rule_list_count;
    uint8_t event_rule_list_count;
    uint32_t ttl;
    struct list_head rule_list_head;
    struct list_head event_rule_list_head;
} pid_spec_id_t;

typedef struct pid_spec_id_list {
    pid_spec_id_t pid_spec_id;
    struct list_head list;
} pid_spec_id_list_t;

//for properties
int spec_rule_add(pid_spec_id_t *pid_spec_id, spec_rule_t *p_rule);
int spec_rule_delete(pid_spec_id_t *pid_spec_id, spec_id_v2_t spec_id);
spec_rule_t *spec_rule_search(uint16_t pid, spec_id_v2_t spec_id);
int spec_rule_print(uint16_t pid);

//for events
int spec_event_rule_add(pid_spec_id_t *pid_spec_id, spec_event_rule_t *p_rule);
int spec_event_rule_delete(pid_spec_id_t *pid_spec_id, spec_id_v2_t spec_id);
spec_event_rule_t *spec_event_rule_search(uint16_t pid, spec_id_v2_t spec_id);
int spec_event_rule_print(uint16_t pid);


int pid_spec_id_init(void);
int pid_spec_id_add(pid_spec_id_t *p_pid_spec_id);
int pid_spec_id_delete(uint16_t pid);
pid_spec_id_t *pid_spec_id_search(uint16_t pid);
int pid_spec_id_print(void);
int pid_spec_id_decrease_ttl(void);

int query_buffer_add(pid_spec_id_t *p_pid_spec_id);
int query_buffer_delete(uint16_t pid);
pid_spec_id_t *query_buffer_search(uint16_t pid);
int query_buffer_decrease_ttl(void);


bool mibeacon_check_spec_delta(mibeacon_object_t *p_old,mibeacon_object_t *p_new, spec_rule_t *spec_rule);

int spec_rule_copy(pid_spec_id_t *dst, pid_spec_id_t *src);

#endif
