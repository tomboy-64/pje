#include <stdbool.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define FILENAME "p022_names.txt"
typedef struct name name;
struct name {
  char actual[50];
  int value;
  name * next;
};

bool get_next_char(char * storage, FILE * fp) {
  *storage = fgetc(fp);
  if( *storage == EOF ) {
    return 0;
  } else {
    return 1;
  }
} 

name * read_file() {
  FILE *fp = fopen (FILENAME, "r");

  if( fp == NULL ) {
    printf("Opening %s failed.\n", FILENAME);
  }
  
  name * result = calloc(1, sizeof(name));
  name * cur_name = result;
  char nextchar;
  for (;;) {
    get_next_char( &nextchar, fp );
    if( nextchar != '"' ) {
      printf("Error: expected ''; got %c.\n", nextchar);
      exit(1);
    }

    int counter = 0;
    get_next_char( &nextchar, fp );
    do{ 
      cur_name->actual[counter] = nextchar;
      counter++;
      if( counter > 50 ) {
        printf("Error: string getting too big: %s.\n", cur_name->actual);
        exit(1);
      }

      get_next_char( &nextchar, fp );
    } while( nextchar != '"' );
    cur_name->actual[counter] = '\0';

    get_next_char( &nextchar, fp );
    if( nextchar == EOF ) {
      return result;
    } else if( nextchar != ',' ) {
      printf("Error: expected ,; got %c.\n", nextchar);
      exit(1);
    } else {
      cur_name->next = calloc(1, sizeof(name));
      cur_name = cur_name->next;
    }
  }
}

void sort_names(name * input) {
  bool again = true;
  while( again ) {
    again = false;

    name * cur_name = input;
    while( cur_name->next != NULL ) {
      if( strcmp( cur_name->actual, cur_name->next->actual ) > 0 ) {
        char tmp[50];
        strcpy( tmp, cur_name->actual );
        strcpy( cur_name->actual, cur_name->next->actual );
        strcpy( cur_name->next->actual, tmp );

        again = true;
      }
      cur_name = cur_name->next;
    }
  }
}

void convert_names(name * input) {
  int sum;
  while( input != NULL ) {
    sum=0;
    for( int i=0; i<strlen(input->actual); i++ ) {
      sum = sum + (int) input->actual[i] - 64;
    }
    input->value = sum;
    input = input->next;
  }
}
        
int main() {
  printf("Reading file ...");
  name * name_list = read_file();
  printf(" done.\n");

  printf("Sorting names ...");
  sort_names(name_list);
  printf(" done.\n");

  printf("Calculating name numeric values ...");
  convert_names(name_list);
  printf(" done.\n");
  
  uint64_t counter=0;
  uint64_t summ=0;
  uint64_t intermediate;
  while( name_list->next != NULL ) {
    counter++;
    intermediate=counter * name_list->value;
    summ = summ + intermediate;

    printf("%"PRIu64": %d - %"PRIu64" - %"PRIu64" %s\n", counter, name_list->value, intermediate, summ, name_list->actual);

    name_list = name_list->next;
  }
  printf("Result: %" PRIu64 "\n", summ);
}
