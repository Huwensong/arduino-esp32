//
// Created by Huwensong on 2022/7/4.
//

#ifndef MIIO_APP_MIIO_INTERFACE_H
#define MIIO_APP_MIIO_INTERFACE_H

#ifdef __cplusplus
extern "C" {
#endif

#define GMT_OFFSET_MAX          (25)  // 全球24个时区

#include "miio_define.h"

int inf_miio_set_otp(uint64_t did, const char *psk);

int inf_miio_set_model(const char *md);

int inf_miio_set_uid(const uint16_t uid);

int inf_miio_set_country_domain(const char *contry);

int inf_miio_set_gmt_offset(const int gmt_offset);

int inf_miio_set_wifi_ssid(const char *ssid);

int inf_miio_set_wifi_psw(const char *password);

int inf_miio_get_model(char *md);

int inf_miio_get_uid();

int inf_miio_get_country_domain(char *cd);

int inf_miio_get_gmt_offset();

int inf_miio_get_wifi_ssid(char *ssid);

int inf_miio_get_wifi_psw(char *password);

#ifdef __cplusplus
}
#endif

#endif //MIIO_APP_MIIO_INTERFACE_H
