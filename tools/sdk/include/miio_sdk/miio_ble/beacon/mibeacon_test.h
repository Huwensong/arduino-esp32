#ifndef __MIBEACON_TEST_H__
#define __MIBEACON_TEST_H__

void mibeacon_device_set_test(void);
void mibeacon_upload_test(void);
void mibeacon_parse_test(void);
void miband_set(void);
void miband_test(void);

void mibeacon_aes_ccm_test(void);

void mibeacon_spec_test(void);
void mibeacon_spec_upload_test(void);

void mible_dev_work_flow_test(void);

#ifdef PRPH_STATISTIC_TEST_ENABLE
void mibeacon_send_by_serial_test(void);
#endif
#endif
