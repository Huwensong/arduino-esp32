#ifndef __MIBLE_STATISTIC_H__
#define __MIBLE_STATISTIC_H__

#define MAX_STATISTIC_ROW           15
#define MAX_CONTENT_LENGTH          108
#define MAX_TITLE_LENGTH            10
#define MIBLE_STATISIC_REPORT_ITVL  60
#define MIBLE_PERIPHERAL_DATA_CHECK_ITVL                  1800

typedef struct {
    char title[MAX_STATISTIC_ROW][MAX_TITLE_LENGTH];
    char content[MAX_STATISTIC_ROW][MAX_CONTENT_LENGTH];
    int intvl[MAX_STATISTIC_ROW];   //intvl == 0 means report within 1 min
    uint32_t last_report[MAX_STATISTIC_ROW];
    uint8_t refresh[MAX_STATISTIC_ROW];
    arch_os_mutex_handle_t mutex;
} mible_statistic_t;

int mible_statistic_init(void);
void mible_report_statistic_periodically(void);
int mible_gather_statistic(const char *title, const char *content, int intvl);
void mible_prph_check(void);

#endif

