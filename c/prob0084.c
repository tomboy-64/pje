#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define DICE 4
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_RESET   "\x1b[0m"

int verbose = 0;

/* return a random number between 0 and limit inclusive.*/
int my_rnd(int limit) {
    int divisor = RAND_MAX/(limit+1);
    int retval;
    
    do { 
        retval = rand() / divisor;
    } while (retval > (limit));

    return (retval);
}

int throw_dice() {
    return (my_rnd(DICE-1)+1);
}

enum squares {
    GO=0, A1, CC1, A2, T1, R1, B1, CH1, B2, B3, JAIL
    , C1, U1, C2, C3, R2, D1, CC2, D2, D3, FP, E1, CH2
    , E2, E3, R3, F1, F2, U2, F3, G2J, G1, G2, CC3, G3
    , R4, CH3, H1, T2, H2
} pos=GO;

void init_cchest(int *cchest) {
    int *check = calloc(16, sizeof(int));
    int i = 0;
    int card;
    
    check[0] = GO+1;
    check[1] = JAIL+1;
    
    printf("Initializing Community Chest: ");
    while (i<16) {
        card = my_rnd(15);
        if (check[card] >= 0) {
            cchest[i] = check[card];
            check[card] = -1;
            printf("%d ", cchest[i]);
            i++;
        }
    }
    printf("\n");
}

void init_chance(int *chance) {
    int *check = calloc(16, sizeof(int));
    int i = 0;
    int card;
    
    check[0] = GO+1;
    check[1] = JAIL+1;
    check[2] = C1+1;
    check[3] = E3+1;
    check[4] = H2+1;
    check[5] = R1+1;
    check[6] = -1; //go to next R
    check[7] = -1;
    check[8] = -2; //go to next U
    check[9] = -3; //go back 3 squares
    
    printf("Initializing Chance: ");
    while (i<16) {
        card = my_rnd(15);
        if (check[card] >= -3) {
            chance[i] = check[card];
            check[card] = -10;
            printf("%d ", chance[i]);
            i++;
        }
    }
    printf("\n");
}

int rotate_deck(int *deck) {
    int cache = deck[0];
    if (verbose == 1) printf("Rotating deck: ");
    for (int i=0; i<15; i++) {
        deck[i] = deck[i+1];
        if (verbose == 1) printf("%d ", deck[i]);
    }
    deck[15] = cache;
    if (verbose == 1) printf("%d\n", deck[15], deck[15]);
    
    if (cache > 0) {
        return (cache-1);
    } else if (cache < 0) {
        return cache;
    } else {
        return -10;
    }
}
        
int main()
{
    srand(time(NULL));

    int doubles = 0;

    int *field  = calloc(39, sizeof(int));
    int *cchest = malloc(16*sizeof(int));
    int *chance = malloc(16*sizeof(int));
    
    init_cchest(cchest);
    rotate_deck(cchest);
    init_chance(chance);
    rotate_deck(chance);
    
    int loop = 0;
    
    int dice1;
    int dice2;
    
    while (loop < 10000000) {
        loop++;
        
        dice1 = throw_dice();
        dice2 = throw_dice();
        if (verbose == 1) printf("%d: dice: %d %d - ", loop++, dice1, dice2);
        
        if (dice1 == dice2) {
            doubles++;
        } else {
            doubles = 0;
        }
        if (doubles == 3) {
            if (verbose == 1) printf("\nTriple double!\n");
            pos = JAIL;
            doubles = 0;
        } else {
            pos += (dice1+dice2);
        }
        if (pos > 39) {pos -= 40;}
        if (pos == G2J) {pos = JAIL;}

        
        // chance square
        if (pos == CH1 || pos == CH2 || pos == CH3) {
            if (verbose == 1) printf("chance square\n");
            int card = rotate_deck(chance);
            
            if (card >= 0) { pos = card; }
        }
        
        // community chest square
        if (pos == CC1 || pos == CC2 || pos == CC3) {
            if (verbose == 1) printf("community chest square\n");
            int card = rotate_deck(cchest);
            
            if (card >= 0) {
                pos = card;
            } else if (card == -1) {
                if (CC1 == pos) {
                    pos = R1;
                } else if (CC2 == pos) {
                    pos = R3;
                } else if (CC3 == pos) {
                    pos = R4;
                }
            } else if (card == -2) {
                if (CC1 == pos || CC3 == pos) {
                    pos = U1;
                } else if (CC2 == pos) {
                    pos = U2;
                }
            } else if (card == -3) {
                if (pos == CC1) {
                    pos = 39;
                } else {
                    pos -= 3;
                }
            }
        }
   
        field[pos] += 1;
        if (verbose == 1) printf("pos: %d\n", pos);
        
        if (loop % 1000000 == 0) {
            int fieldsum = 0;
            for (int i=0; i<40; i++) {
                fieldsum += field[i];
            }
            printf("  GO   A1  CC1   A2   T1   R1   B1  CH1   B2   B3 JAIL   C1   U1   C2   C3   R2   D1  CC2   D2   D3   FP   E1  CH2   E2   E3   R3   F1   F2   U2   F3  G2J   G1   G2  CC3   G3   R4  CH3   H1   T2   H2\n");

            int* topFieldsPos   = calloc(3, sizeof(int));
            int* topFieldsCount = calloc(3, sizeof(int));
            for (int i=0; i<40; i++) {
                if (field[i] > topFieldsCount[2]) {
                    topFieldsCount[2] = field[i];
                    topFieldsPos[2] = i;
                    
                    for (int j=2; j>1; j--) {
                        if (topFieldsCount[j] > topFieldsCount[j-1]) {
                            int countCache = topFieldsCount[j];
                            int posCache = topFieldsPos[j];
                            topFieldsCount[j] = topFieldsCount[j-1];
                            topFieldsPos[j] = topFieldsPos[j-1];
                            topFieldsCount[j-1] = countCache;
                            topFieldsPos[j-1] = posCache;
                        }
                    }
                }
            }
                            
            for (int i=0; i<40; i++) {
                if (i==topFieldsPos[0] || i==topFieldsPos[1] || i==topFieldsPos[2]) {
                    printf(ANSI_COLOR_RED "%.2f" ANSI_COLOR_RESET " ", (double) field[i]/(double) fieldsum * 100);
                } else {
                    printf("%.2f ", (double) field[i]/(double) fieldsum * 100);
                }
            }
            printf("\n");
        }
    }
    
    return 0;
}

// GO 2.82
// A2 2.09
// T1 2.19
// R1 2.66
// JAIL 6.95
// C3 2.93
// R2 3.36
// D1 3.21
// E3 3.24
