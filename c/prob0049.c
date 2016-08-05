#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct link link;
struct link {
  int prime;
  link * next;
};

typedef struct llength_chain llength_chain;
struct llength_chain {
  link * primes_chain;
  llength_chain * next_chain;
};

void remove_link(link * first, const int removee) {
  while(first->next->prime != removee) {
    if (first->prime >= 10000) {
      printf("Error: couldn't remove %d from list.\n", removee);
      exit(1);
    }
    first = first->next;
  }
  link * tmp = first->next->next;
  free(first->next);
  first->next = tmp;
}

// takes a number and sorts its digits
// only works with 4-digit numbers
int sort_digits(int input) {
  // splits up the number into an array.
  // only works with 4 digit numbers
  int unsorted[4] = { input/1000, 0, 0, 0 };
  input = input % 1000;
  unsorted[1] = input / 100;
  input = input % 100;
  unsorted[2] = input / 10;
  unsorted[3] = input % 10;

  // digit is smaller than 1000
  // instant error
  if (unsorted[0] == 0) {
    printf("Error: input for sort_digits < 1000: %d.\n", input);
    exit(1);
  }

  // bubble sort
  bool again = true;
  while (again) {
    again = false;
    for (int i=0; i<3; i++) {
      if (unsorted[i] < unsorted[i+1]) {
        again = true;
        int tmp = unsorted[i+1];
        unsorted[i+1] = unsorted[i];
        unsorted[i] = tmp;
      }
    }
  }

  // turn the array into an int again
  int sorted = 0;
  for (int i=0; i<4; i++) {
    sorted *= 10;
    sorted += unsorted[i];
  }
  return sorted;
}

void create_primes(link * first) {
  //printf("%d", first->prime);
  link * lastlink = first;
  for (int i=3; i<10000; i++) {
  link * testlink = first;
    for (;;) {
      if (pow(testlink->prime,2) > i) {
        // we're in the clear; append i
        link * newlink = calloc(1, sizeof(link));
        newlink->prime = i;
        lastlink->next = newlink;
        lastlink = newlink;
        //printf(", %d", i);
        break;
      } else if ((i % testlink->prime) == 0) {
        // is divisible by some other prime
        //printf(", (%d/%d)", i, testlink->prime);
        break;
      }
      testlink = testlink->next;
    }
  }
}

link * first_4_digit_prime(link * first) {
  link * tmp;
  while(first->prime < 1000) {
    tmp = first;
    first = first->next;
    free(tmp);
  }
  return first;
}

llength_chain * create_llc(link * first) {
  llength_chain * llc = calloc(1, sizeof(llength_chain));
  llength_chain * llc_walker = llc;

  link * sweeper_prev_dummy = calloc(1, sizeof(link));
  link * link_walker = NULL;
  while( first != NULL ) {
    link * sweeper_prev = sweeper_prev_dummy;
    link * sweeper = first;
    int min_prime = sort_digits(first->prime);

    while( sweeper != NULL ) {
      //printf("sweeper->prime: %d; min_prime: %d\n", sweeper->prime, min_prime);
      if (sort_digits(sweeper->prime) == min_prime) {
        if ( llc_walker->primes_chain == NULL ) {
          llc_walker->primes_chain = sweeper;
          link_walker = sweeper;
//          printf("\n|");
        } else {
          link_walker->next = sweeper;
          link_walker = link_walker->next;
//          printf(".");
        }

        if (sweeper == first) {
//          printf(" %d ", sweeper->prime);
          first = sweeper->next;
        }

        sweeper_prev->next = sweeper->next;
        sweeper->next = NULL;
      } else {
        sweeper_prev = sweeper;
      }
      sweeper = sweeper_prev->next;
    }

    sweeper_prev->next = NULL;
    if( first != NULL ) {
      llc_walker->next_chain = calloc(1, sizeof(llength_chain));
      llc_walker = llc_walker->next_chain;
    }
  }
  free(sweeper_prev_dummy);
//  free(llc_walker);
  llc_walker = NULL;
  return llc;
}

int final(llength_chain * input) {
  int result = 1;
  link * first;
  link * second;
  link * third;
  int difftwo, diffthree;
  while( input != NULL ) {
    first = input->primes_chain;
    while( first != NULL ) {
//printf("first: %d\n", first->prime);
      second = first->next;
      while( second != NULL ) {
        difftwo = second->prime - first->prime;
//printf(" second: %d, diff: %d, 2nd-next: %p\n", second->prime, difftwo, second->next);
        third = second->next;
        while( third != NULL ) {
//printf("  third: %d, diff: %d\n", third->prime, diffthree);
          diffthree = third->prime - second->prime;
          if(diffthree == difftwo) {
            // We're done here.
            printf("Result: %d %d %d, difference %d.\n",
                first->prime, second->prime, third->prime, difftwo);
            result = 0;
            third = third->next;
          } else if (diffthree < difftwo) {
            third = third->next;
          } else {
            third = NULL;
          }
        }
        second = second->next;
      }
      first = first->next;
    }
    input = input->next_chain;
  }
  return result;
}

int main() {
  link * start = calloc(1, sizeof(link));
  start->prime = 2;

  printf("Creating all needed primes ...");
  create_primes( start );
  printf(" done.\n");

  printf("Deleting too small primes ...");
  start = first_4_digit_prime( start );
  printf(" done.\n");

  printf("Creating limited length chains ...");
  llength_chain * llc = create_llc( start );
  printf(" done.\n");

  printf("Performing final filter ... \n");
  return final(llc);

/*  printf("Test 8237: %d\n", sort_digits(8237));
  printf("First 4 digit prime: %d\n", (first_4_digit_prime( &start ))->prime);
  printf("Removing first 4 digit prime ...");
  remove_link(&start, first_4_digit_prime( &start )->prime);
  printf(" done.\n");
  printf("First 4 digit prime: %d\n", (first_4_digit_prime( &start ))->prime);*/
}
