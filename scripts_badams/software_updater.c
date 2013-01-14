/*
To be chmod +s 'ed and placed as post-commit hook in /Users/badams/Repositories/software_public_html/
*/
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  execl("/usr/bin/svn", "svn", "update", "/Users/software/Sites/", (const char *) NULL);
  return(EXIT_FAILURE);
}
