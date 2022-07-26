#ifndef __MIIO_ROAM_MAC_H
#define __MIIO_ROAM_MAC_H
#include "miio_define.h"
struct miio_net;

typedef struct{
    uint8_t bssid[6];
    uint8_t channel;
    uint8_t phy_type;
} miio_neighbor_ap_t;

int miio_roam_init(miio_net_t *miio_net);
int miio_roam_set_rssi_threshold(int32_t rssi);
int miio_send_neighbor_rep_request(void);
int miio_get_neighbor_ap(miio_neighbor_ap_t *ap, uint8_t idx);
uint8_t miio_get_neighbor_ap_num(void);

#endif  //__MIIO_ROAM_MAC_H

