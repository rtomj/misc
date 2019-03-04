/* zap: interactive process killer 
 * from The UNIX Programming Environment
 */

#include <stdio.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>

char	*progname;
char *ps = "ps ax";

int strindex(char *s, char *t);

int main(int argc, char *argv[])
{
	FILE *fp, *popen();
	char buf[BUFSIZ];
	int pid;
	char p;

	progname = argv[0];
	if ((fp = popen(ps, "r")) == NULL) {
		fprintf(stderr, "%s: can't run %s\n", progname, ps);
		exit(1);
	}
	fgets(buf, sizeof buf, fp);
	fprintf(stderr, "%s", buf);
	while (fgets(buf, sizeof buf, fp) != NULL)
		if (argc == 1 || strindex(buf, argv[1]) >= 0) {
			buf[strlen(buf)-1] = '\0';
			fprintf(stderr, "%s ? ", buf);
			if ((p = getchar()) == 'y') {
				sscanf(buf, "%d\n", &pid);
				kill(pid, SIGKILL);
			}
		}
	printf("\n");
	exit(0);
}

int strindex(char *s, char *t)
{
	int i, n;
	
	n = strlen(t);
	for (i = 0; s[i] != '\0'; i++)
		if (strncmp(s+i, t, n) == 0)
			return i;
	return -1;
}

 
