/*
To be chmod +s 'ed and placed as post-commit hook in /Users/badams/Repositories/eclipse_public_html/
*/
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
//  execl("/usr/bin/svn", "svn", "update", "/Users/webmaster/eclipse_html/", (const char *) NULL);
  execl("/usr/bin/svn", "svn", "update", "/Library/Server/Web/Data/Sites/Eclipse_Root/", (const char *) NULL);
  return(EXIT_FAILURE);
}
