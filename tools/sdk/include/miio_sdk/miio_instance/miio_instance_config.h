#ifndef _MIIO_INSTANCE_CONFIG_H_
#define _MIIO_INSTANCE_CONFIG_H_

#include "lwip/opt.h"
#include "miio_version.h"

#include "miio_config.h"

#define MIIO_INSTANCE_MODEL				"pio.flowerpot.ivy01"
#if MIBLE_ENABLE
#define MIBLE_PRODUCT_ID                904
#endif
#define MIIO_APP_VERSION_NUMBER			1
#define MIIO_COMMANDS_ENABLE			0
#ifndef MIIO_INSTANCE_LX2_ADAPT
#define MIIO_INSTANCE_LX2_ADAPT			0
#endif
#if MIIO_INSTANCE_LX2_ADAPT
#define MIIO_PSM_ENABLE					1
#else
#define MIIO_PSM_ENABLE					0
#endif

#define MIIO_LOG_ANSI_COLOR_ENABLE		1
#define MIIO_HANDSHAKE_ENABLE			1
#define MIIO_HANDSHAKE_TEST				0
#define MIIO_CONFIG_ROUTER_SAFE_ENABLE	1
#define MIIO_CONFIG_ROUTER_SAFE_TEST	0

#define MIIO_MONITOR_REBOOT_ENABLE				0
#define MIIO_MONITOR_INTERVAL_S					(1)
#define MIIO_MONITOR_INFO_TIMEOUT_S				(10)
#define MIIO_MONITOR_OFFLINE_TIMEOUT_S			(10*60)
#define MIIO_MONITOR_AP_TIMEOUT_S				(30*60)
#define MIIO_MONITOR_STA_CONNECT_INTEVAL_S 		(5)
#define MIIO_MONITOR_REBOOT_TIMEOUT_S			(60*60)
#define MIIO_MONITOR_NTP_INTEVAL_S 				(15)

#define MIIO_NET_HIDDENSSID_RETRY				(2)
#define MIIO_NET_MASTERSSID_RETRY				(3)
#define MIIO_NET_SMART_CONFIG_TIMEOUT_S			(30)

#define MIIO_NET_INDICATOR_ENABLE				0
#define MIIO_NET_INDICATOR_LED_SINGLE			1
#define MIIO_NET_INDICATOR_LED_PIN_BLUE			14
#if !MIIO_NET_INDICATOR_LED_SINGLE
#define MIIO_NET_INDICATOR_LED_PIN_YELLOW		12
#endif
#define MIIO_NET_INDICATOR_LED_COMMON_CATHODE	0

#define MIIO_KV_ENCRYPT_ENABLE                  0
#define MIIO_KV_SAVE_UNENCRYPTED                0
#define MIIO_KV_STAT_REPORT_ENABLE              0
#define MIIO_KV_STAT_CHECK_GAP                  15
#define MIIO_KV_STAT_REPORT_MIN_GAP             (60*60)


#if MIIO_OFFLINE_RECOVERY_ENABLE
#define MIIO_OFFLINE_RECOVERY_TIMEOUT           (4*60)   // shorter than MIIO_MONITOR_OFFLINE_TIMEOUT_S
#define MIIO_OFFLINE_OT_RECONNECT_COUNTOUT      10
#define MIIO_ONLINEFAIL_FAST_RECOVERY_ENABLE    0
#endif

#ifndef MIIO_SKIP_INVALID_BSSID_ENABLE
#define MIIO_SKIP_INVALID_BSSID_ENABLE          1
#endif
#if MIIO_SKIP_INVALID_BSSID_ENABLE
#define MIIO_SKIP_INVALID_BSSID_MAX_COUNT       (MIIO_NET_HIDDENSSID_RETRY*3)
#define MIIO_SKIP_INVALID_BSSID_MAX_TIME_S      180
#endif

#ifndef MIIO_ROAM_ENABLE
#define MIIO_ROAM_ENABLE                        0
#endif
#if MIIO_ROAM_ENABLE
#define MIIO_ROAM_RSSI_THRESHOLD                (-70)
#define MIIO_ROAM_RSSI_HYSTERESIS               (15)
#define MIIO_ROAM_RSSI_DELTA                    (20)
#define MIIO_ROAM_COOLDOWN_TIME_S_MIN           (60*10)
#define MIIO_ROAM_COOLDOWN_TIME_S_MAX           (60*60*1)
#define MIIO_ROAM_COOLDOWN_TIME_S_FIRST         (60)
#endif

#if MIIO_AUTO_OTA_ENABLE
#ifndef MIIO_AUTO_OTA_ABILITY
#define MIIO_AUTO_OTA_ABILITY					0
#endif
#endif

#ifndef MIIO_WIFI_SWITCH_ENABLE
#define MIIO_WIFI_SWITCH_ENABLE					0
#endif

#if ((MIIO_IPV6_CAPABILITY) && !(ESP_IPV6_AUTOCONFIG))
#error You have enabled IPv6 feature, please configure esp-idf  \
    'CONFIG_LWIP_IPV6_AUTOCONFIG=y' to support IPv6 stateless   \
    address autoconfiguration. Otherwise you may not be able to \
    get the IPv6 global address.
#endif

#endif
