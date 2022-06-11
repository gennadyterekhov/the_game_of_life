#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <unistd.h>


const int width = 10;
const int height = 10;
int timeout = 200;
char** previousPoints[10][10];
char** points[10][10]; 
char aliveStr[] = "■ ";
char deadStr[] = "□ ";


int countAliveNeighbours(int x, int y) {
    int aliveCount = 0;
    for (int i = y - 1; ((i <= y + 1) && (i < height)); i++) {
        for (int j = x - 1; ((j <= x + 1) && (j < width)); j++) {
            if (
                i >= 0 && j >= 0
                && (i != y || j != x)
            ) {
                aliveCount += (int)(previousPoints[i][j]);
            }
        }
    }
    return aliveCount;
}

char getMutatedPoint(int x, int y) {
    int aliveNeighbours = countAliveNeighbours(x, y);
    char alive = (points[y][x] == 1) ? 1 : 0;
    return ((alive && (aliveNeighbours == 2)) || (aliveNeighbours == 3));
}

void updatePoints() {
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            points[i][j] = getMutatedPoint(j, i);
        }
    }
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            previousPoints[i][j] = points[i][j];
        }
    }
}

// void uninitializePoints() {
//     for (int i = 0; i < height; i++) {
//         delete[] points[i];
//         delete[] previousPoints[i];           
//     }
// }


// void initializePoints(char **previousPoints, char **points, int height, int width) {
//     for (int i = 0; i < height; i++) {

//         points[i] = new bool [width];
//         previousPoints[i] = new bool [width];

//         for (int j = 0; j < width; j++) {

//             bool temp = bool(rand() % 2); 
//             points[i][j] = temp;
//             previousPoints[i][j] = temp;
//         }            
//     }
// }




int main(int argc, char** argv) {

    printf("Game start.\n");

    // initializePoints(previousPoints, points);
    
    srand(time(NULL));   // Initialization, should only be called once.
    int r = rand(); 


    for (int i = 0; i < height; ++i) {

        // points[i] = new bool [width];
        // previousPoints[i] = new bool [width];

        for (int j = 0; j < width; j++) {

            char temp = (char)(rand() % 2); 
            points[i][j] = temp;
            previousPoints[i][j] = temp;
        }            
    }


    for (int i = 0;; ++i) {
        printf("\n    ITERATION %i\n", i);
        // show();
        // show
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
        // \show

        updatePoints();
        usleep(200 * 1000);
    }


    printf("Game over.\n");

    return 0;
}

