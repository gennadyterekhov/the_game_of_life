#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <unistd.h>



int main(int argc, char** argv) {

    int width = 10;
    int height = 10;
    int timeout = 200;
    char** previousPoints[height][width];
    char** points[height][width]; 
    char aliveStr[] = "■ ";
    char deadStr[] = "□ ";

    printf("Game start.\n");
    
    srand(time(NULL));
    int r = rand(); 


    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; j++) {
            char temp = (char)(rand() % 2); 
            points[i][j] = temp;
            previousPoints[i][j] = temp;
        }            
    }


    for (int i = 0;; ++i) {
        printf("\n    ITERATION %i\n", i);

        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                if (points[i][j]) {
                    printf("%s", aliveStr);
                } else {
                    printf("%s", deadStr);
                }
            }
            printf("\n");
        }


        // updatePoints

        for (int i = 0; i < height; ++i) {
            for (int j = 0; j < width; ++j) {

                // count alive neigh
                int aliveNeighbours = 0;

                for (int k = i - 1; ((k <= i + 1) && (k < height)); ++k) {
                    for (int l = j - 1; ((l <= j + 1) && (l < width)); ++l) {
                        if (
                            k >= 0
                            && l >= 0
                            && (k != i || l != j)
                        ) {
                            aliveNeighbours += (int)(previousPoints[k][l]);
                        }
                    }
                }
                // \count alive neigh



                char alive = (points[i][j] == 1) ? 1 : 0;
                char mutatedPoint = (char)((alive && (aliveNeighbours == 2)) || (aliveNeighbours == 3));
                points[i][j] = mutatedPoint;
            }
        }
        for (int i = 0; i < height; ++i) {
            for (int j = 0; j < width; ++j) {
                previousPoints[i][j] = points[i][j];
            }
        }
        // \updatePoints



        usleep(200 * 1000);
    }


    printf("Game over.\n");

    return 0;
}

