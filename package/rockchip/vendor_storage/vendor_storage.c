
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

//#define VENDOR_STORAGE_DEBUG
typedef		unsigned short	    uint16;
typedef		unsigned int	    uint32;
typedef		unsigned char	    uint8;

#define VENDOR_REQ_TAG		0x56524551
#define VENDOR_READ_IO		_IOW('v', 0x01, unsigned int)
#define VENDOR_WRITE_IO		_IOW('v', 0x02, unsigned int)

#define VENDOR_ID_MAX	5
static char *vendor_id_table[] = {
	"VENDOR_SN_ID",
	"VENDOR_WIFI_MAC_ID",
	"VENDOR_LAN_MAC_ID",
	"VENDOR_BT_MAC_ID",
	"VENDOR_IMEI_ID",
};

#define VENDOR_SN_ID		1
#define VENDOR_WIFI_MAC_ID	2
#define VENDOR_LAN_MAC_ID	3
#define VENDOR_BT_MAC_ID	4
#define VENDOR_IMEI_ID		5

struct rk_vendor_req {
	uint32 tag;
	uint16 id;
	uint16 len;
	uint8 data[1024];
};

static char *argv0;

static void rknand_print_hex_data(uint8 *s, struct rk_vendor_req *buf, uint32 len)
{
	unsigned char i = 0;

#ifdef VENDOR_STORAGE_DEBUG
	fprintf(stdout, "%s\n",s);
	fprintf(stdout, "tag = %d // id = %d // len = %d // data = 0x%p\n", buf->tag, buf->id, buf->len, buf->data);
#endif

	printf("%s: ", vendor_id_table[buf->id - 1]);
	if (buf->id == VENDOR_SN_ID ||
	    buf->id == VENDOR_IMEI_ID) {
		for (i = 0; i < len; i++)
			printf("%c", buf->data[i]);
	} else {
		for (i = 0; i < len; i++)
			printf("%02x", buf->data[i]);
	}
	fprintf(stdout, "\n");
}

static int vendor_storage_read(int cmd)
{
	uint32 i;
	int ret ;
	uint8 p_buf[100]; /* malloc req buffer or used extern buffer */
	struct rk_vendor_req *req;

	req = (struct rk_vendor_req *)p_buf;
	memset(p_buf, 0, 100);
	int sys_fd = open("/dev/vendor_storage", O_RDWR, 0);
	if(sys_fd < 0){
		printf("vendor_storage open fail\n");
		return -1;
	}

	req->tag = VENDOR_REQ_TAG;
	req->id = cmd;
	req->len = 50;

	ret = ioctl(sys_fd, VENDOR_READ_IO, req);

	if(ret){
		printf("vendor read error %d\n", ret);
		return -1;
	}
	close(sys_fd);

	rknand_print_hex_data("vendor read:", req, req->len);

	return 0;
}

static int vendor_storage_write(int cmd, char *num)
{
	uint32 i;
	int ret ;
	uint8 p_buf[100]; /* malloc req buffer or used extern buffer */
	struct rk_vendor_req *req;

	req = (struct rk_vendor_req *)p_buf;
	int sys_fd = open("/dev/vendor_storage",O_RDWR,0);
	if(sys_fd < 0){
		printf("vendor_storage open fail\n");
		return -1;
	}

	req->tag = VENDOR_REQ_TAG;
	req->id = cmd;

	if (cmd != VENDOR_SN_ID && cmd != VENDOR_IMEI_ID)
		req->len = 6;
	else
		req->len = strlen(num);
	memcpy(req->data, num, req->len);

	ret = ioctl(sys_fd, VENDOR_WRITE_IO, req);
	if(ret){
		printf("vendor write error\n");
		return -1;
	}

	rknand_print_hex_data("vendor write:", req, req->len);
	return 0;
}

static void usage(void)
{
	int i;

	fprintf(stderr,
		"vendor storage tool - Revision: 1.0 \n\n"
		"%s [-r <vendor_id>] [-R] [-w <cmd_string]>]\n"
		"  -r <vendor_id>       Read specify vendor_id\n"
		"  -R                   Read all vendor_id\n"
		"  -w <cmd_string>      Write specify vendor_id\n"
		"  <vendor_id>          There are %d types\n",
		argv0, VENDOR_ID_MAX);
	for (i = 0; i < VENDOR_ID_MAX; i++)
		fprintf(stderr,
		"                       \"%s\"\n", vendor_id_table[i]);
	fprintf(stderr,
		"  <cmd_string>         The string to control num write to storage\n"
		"Examples:\n"
		"  %s -r VENDOR_SN_ID   Read sn_id from storage\n"
		"  %s -w \"VENDOR_SN_ID 0123456789ABCDEF\"\n"
		"                       Write SN_ID 0123456789ABCDEF to storage\n",
		argv0, argv0);
	exit(1);
}

static int vendor_len_mask(int cmd, int len, int cnt)
{
	if (cnt != len) {
		printf("ERROR: %s must be %d bytes!!!\n",
		       vendor_id_table[cmd - 1], len);
		return -1;
	}
	return 0;
}

static void vendor_storage_write_cmd_parse(char *cmd)
{
	char space = ' ';
	int i, cnt, tmp, id = 0xff;
	unsigned char vendor_id[20];
	unsigned char vendor_num[20];
	unsigned char vendor_hex[10];

	cnt = strlen(cmd);

	while (cmd[cnt -1] == space) {
		cnt --;
	}

	while (cmd[0] == space) {
		cmd++;
		cnt--;
		if (cnt == 0)
			goto form_error;
	}

	tmp = cnt;
	for (i = 0; i < tmp; i++) {
		if (cmd[i] == space) {
			memset(vendor_id, 0, sizeof(vendor_id));
			memcpy(vendor_id, cmd, i + 1);
			cmd += i;
			cnt -= i;
			break;
		}
	}

	if (cnt == tmp)
		goto form_error;

	while (cmd[0] == space) {
		cmd++;
		cnt--;
		if (cnt == 0)
			goto form_error;
	}

	for (i = 0; i < cnt; i++)
		if (cmd[i] == space)
			goto form_error;

	memset(vendor_num, 0, sizeof(vendor_num));
	memcpy(vendor_num, cmd, cnt);

#ifdef VENDOR_STORAGE_DEBUG
	printf("id = %s\n", vendor_id);
	printf("num = %s\n", vendor_num);
#endif

	for (i = 0; i < 5; i++) {
		if (!memcmp(vendor_id, vendor_id_table[i], strlen(vendor_id_table[i]))) {
			id = i + 1;
			break;
		}
	}

	if (id == 0xff)
		goto form_error;

	switch (id) {
	case VENDOR_SN_ID:
		if (vendor_len_mask(id, 16, cnt))
			goto error;
		break;
	case VENDOR_WIFI_MAC_ID:
	case VENDOR_LAN_MAC_ID:
	case VENDOR_BT_MAC_ID:
		if (vendor_len_mask(id, 12, cnt))
			goto error;
		break;
	case VENDOR_IMEI_ID:
		if (vendor_len_mask(id, 14, cnt))
			goto error;
		break;
	default:
		/* can't reach here */
		goto error;
		break;
	}

	memset(vendor_hex, 0, sizeof(vendor_hex));
	if (id != VENDOR_SN_ID && id != VENDOR_IMEI_ID) {
		tmp = strlen(vendor_num);
		for (i = 0; i < tmp; i++) {
			if (vendor_num[i] < '0' ||
			    (vendor_num[i] > '9' && vendor_num[i] < 'A') ||
			    (vendor_num[i] > 'F' && vendor_num[i] < 'a') ||
			    vendor_num[i] > 'f') {
				printf("%s must be HEX input\n",
				       vendor_id_table[id + 1]);
				goto error;
			}

			/* string to hex */
			if (vendor_num[i] >= '0' && vendor_num[i] <= '9')
				vendor_num[i] -= '0';
			else if (vendor_num[i] >= 'a' && vendor_num[i] <= 'f')
				vendor_num[i] -= 'a' - 10;
			else
				vendor_num[i] -= 'A' - 10;

			if (i & 1)
				vendor_hex[(i - 1) >> 1] = (vendor_num[i - 1] << 4) | vendor_num[i];
		}
	}

	if (id == VENDOR_SN_ID || id == VENDOR_IMEI_ID) {
		if (vendor_storage_write(id, vendor_num))
			goto error;
	} else {
		if (vendor_storage_write(id, vendor_hex))
			goto error;
	}


	printf("vendor write successful!\n");
	return;

form_error:
	printf("ERROR: form_error, check cmd with -h\n");
error:
	return;
}

int main(int argc, char **argv)
{
	int opt, i;

	argv0 = argv[0];
	while ((opt = getopt(argc, argv, "hRr:w:")) > 0) {
		switch (opt) {
		case 'r':
			for (i = 0; i < VENDOR_ID_MAX; i++) {
				if (!memcmp(optarg, vendor_id_table[i], strlen(vendor_id_table[i]))) {
					vendor_storage_read(i + 1);
					break;
				}
			}
			if (i == VENDOR_ID_MAX)
				printf("ERROR: form_error, check cmd with -h\n");
			break;
		case 'R':
			for (i = 0; i < VENDOR_ID_MAX; i++)
				vendor_storage_read(i + 1);
			break;
		case 'w':
			vendor_storage_write_cmd_parse(optarg);
			break;
		case 'h':
			usage();
			break;
		default:
			fprintf(stderr, "Unknown option: %c\n", opt);
			usage();
			break;
		}
	}

	return 0;
}
