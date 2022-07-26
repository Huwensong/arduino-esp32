#ifndef __OTA_APP_H
#define __OTA_APP_H

#include "miio_instance.h"
#include "miio_arch.h"

/*
 * update to ota v2
 *
 * DFU = Firmware + Tag + Sign
 *
 */

/*
 * Tag:
 *   0-15      16-17   18-19   20-23      24-25      26    27    28-N   N+4
 * +-------+----------+-----+---------+-----------+------+-----+-----+-------+
 * | Magic | Tag Size | PID | FW Size | Crts Size | Flag | RES | TLV | CRC32 |
 * +-------+----------+-----+---------+-----------+------+-----+-----+-------+
 *
 * Magic Number:
 * 000000004D49EF54464F544182562647
 *
 * T:
 *    1         2           3        4       5        6
 * +-------+----------+----------+-------+------+----------+
 * | ver   | old ver  | sign type| model | pdid | rom type |
 * +-------+----------+----------+-------+------+----------+
 *
 */

/*
 * Sign:
 *
 * +-----------+----------------+------------+
 * | Open cert | Developer cert |  Signature |
 * +-----------+----------------+------------+
 *
 * Signature = ecc256(sha256(Firmware + Tag))
 */

#define FW_LONG_VERSION_LEN			5
#define FW_SHORT_VERSION_LEN		2

#define FW_TAG_HDR_SIZE				28    /* fixed firmware tag header size */
#define FW_TAG_MAGIC_NURBER_SIZE	16
#define FW_TAG_CRC_SIZE				4
#define FW_TAG_TLV_HDR_SIZE			2
#define FW_TAG_MIN_SIZE				(FW_TAG_HDR_SIZE + FW_TAG_CRC_SIZE)
/* tag stable length is 32 bytes, and TLV len max is 512 */
#define FW_TAG_LEN_MAX				(512 + 32)
#define FW_TAG_LEN_MIN				(32)

#define FW_TAG_FLAG_BSDIFF			0x01
#define FW_TAG_FLAG_RSVD			0xFE

typedef enum {
	FW_SA_ECC256=0x01,
}fw_sign_algorithm_t;

typedef enum {
	FW_TAG_ROM_TYPE_MCU = 0x01,
	FW_TAG_ROM_TYPE_SDK = 0x02,
	FW_TAG_ROM_TYPE_WIFI = 0x03,
	FW_TAG_ROM_TYPE_BT = 0x10,
	FW_TAG_ROM_TYPE_OT = 0x18,
} fw_tag_rom_type_t;

typedef enum {
	FW_TAG_TLV_TYPE_INVALID = 0,
	FW_TAG_TLV_TYPE_NEW_VER_NUMBER = 1,
	FW_TAG_TLV_TYPE_OLD_VER_NUMBER,
	FW_TAG_TLV_TYPE_SA_TYPE,    /* signature algorithm */
	FW_TAG_TLV_TYPE_MODEL_NAME,
	FW_TAG_TLV_TYPE_PDID,
	FW_TAG_TLV_TYPE_ROM_TYPE,
	FW_TAG_TLV_TYPE_MAX,
} fw_tag_tlv_type_t;

/* add all required TLV type here */
#define FW_TAG_TLV_FLAG ( (0x01 << FW_TAG_TLV_TYPE_NEW_VER_NUMBER) \
								| (0x01 << FW_TAG_TLV_TYPE_SA_TYPE) \
								| (0x01 << FW_TAG_TLV_TYPE_MODEL_NAME) \
								| (0x01 << FW_TAG_TLV_TYPE_PDID) )

typedef struct {
	uint8_t magic_num[FW_TAG_MAGIC_NURBER_SIZE];
	uint16_t tag_size;
	uint16_t pdid;  /* if real_pdid > 0xFFFF, pdid = 0; else pdid = real_pdid; */
	uint32_t fw_size;
	uint16_t cert_size;
	uint8_t flag;
	uint8_t reserve;
} firmware_tag_hdr_t;

typedef struct {
	uint16_t major;
	uint16_t minor;
	uint16_t revision;
	uint16_t product;
} firmware_version_t;

#define MIJIA_MODEL_NAME_MAX_LEN		255
#define MIJIA_MANU_NAME_LEN				63
#define MIJIA_PRODUCT_TYPE_LEN			63
#define MIJIA_MODEL_NUMBER_LEN			63

typedef struct {
	uint32_t tlv_mask;
	firmware_version_t ver;
	firmware_version_t old_ver;
	char model_name[MIJIA_MODEL_NAME_MAX_LEN + 1];
	char manu_name[MIJIA_MANU_NAME_LEN + 1];
	char product_type[MIJIA_PRODUCT_TYPE_LEN + 1];
	char model_number[MIJIA_MODEL_NUMBER_LEN + 1];
	uint32_t pdid;
	uint16_t sa_type;
	uint16_t rom_type;
} firmware_tag_info_t;



typedef struct{
	miio_ota_task_handle_t ota_task_handle;
	ota_flash_info_t flash_info;
	bool signed_file;
	uint32_t original_file_len;
	struct{
		uint32_t file_len;
		char org[MIIO_MODEL_SIZE_MAX];
		void* sha256_ctx;
		uint8_t hash[32];
	}verify;
	char model[MIJIA_MODEL_NAME_MAX_LEN + 1];
#if MIIO_AUTO_OTA_ENABLE
	struct {
		bool auto_enable;
		bool force_enable;
	}auto_ota;
#endif /* MIIO_AUTO_OTA_ENABLE */
}miio_ota_app_ctx_t;

int miio_ota_app_init(miio_handle_t miio_handle, miio_ota_app_ctx_t *ota_app_ctx);

#endif
