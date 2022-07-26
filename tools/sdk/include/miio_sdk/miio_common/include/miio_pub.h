#ifndef MIIO_PUB_H_
#define MIIO_PUB_H_

#if MIIO_PUB_ENABLE

#include "miio_arch.h"
#include "miio_define.h"

void mipub_init(void);
void mipub_deinit(void);

/*function: process profile-cmd of props*/
void mipub_publish_cmd_property_profile(miio_handle_t miio_handle, const char *key, const char *value);

/*function: process profile-cmd of event*/
void mipub_publish_cmd_event_profile(miio_handle_t miio_handle, const char *key, const char *value[], size_t value_count);

/*function: pub spec-prop data*/
int mipub_publish_cmd_property_spec(miio_handle_t miio_handle, miio_rpc_delegate_context_t *rpc_context, char *did, uint32_t ssid, uint32_t piid);

#if MIIO_SPEC_V3_ENABLE
/*function: pub spec_v3-prop data*/
int mipub_publish_cmd_property_spec_v3(miio_handle_t miio_handle, miio_rpc_delegate_context_t *rpc_context, char *did, uint32_t miid, uint32_t siid, uint32_t piid);
#endif

/*function: pub spec-event data*/
int mipub_publish_cmd_event_spec(miio_handle_t miio_handle, miio_rpc_delegate_context_t *rpc_context, char *did, uint32_t ssid, uint32_t eiid);

#if MIIO_SPEC_V3_ENABLE
/*function: pub spec_v3-event data*/
int mipub_publish_cmd_event_spec_v3(miio_handle_t miio_handle, miio_rpc_delegate_context_t *rpc_context, char *did, uint32_t miid, uint32_t siid, uint32_t eiid);
#endif

/*function: process heart-beat*/
void mipub_probe_process(uint8_t *did, net_ip_port_t *peer, uint8_t *sign, uint8_t sign_len);

/*function: process pub data*/
bool mipub_forward_delegate_handle(miio_handle_t miio_handle, miio_rpc_delegate_context_t *rpc_context);

/**/
int mipub_publish_ack(miio_rpc_delegate_arg_t *ack_arg, void* ctx);

#endif
#endif
