#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <fstream>
#include <cstdlib>
#include <ctime>
#include <thread>
#include <chrono>

// debug
#include <typeinfo>


class Field {
    public:
        Field(int width, int height) {
            this->width = width;
            this->height = height;
            this->aliveStr = "■ ";
            this->deadStr = "□ ";
            this->points = this->generatePoints();
        }


        void play() {
            bool continueCondition = true;
            for (int i = 0; continueCondition; i++) {
                std::cout << "\n    ITERATION " << i << std::endl;
                this->show();
                this->points = this->getMutatedPoints();
                std::this_thread::sleep_for(std::chrono::milliseconds(200));
            }
        }    


    private:
        int width;
        int height;
        std::string aliveStr;
        std::string deadStr;
        char aliveChar;
        char deadChar;
        char space;
        bool** points;


        std::string pointToString(bool point) {
            return (point) ? this->aliveStr : this->deadStr;
        }


        void show() {
            for (int i = 0; i < this->height; i++) {
                for (int j = 0; j < this->width; j++) {
                    std::cout << this->pointToString(this->points[i][j]);
                }
                std::cout << std::endl;
            }
        }
        

        bool** getMutatedPoints() {
            bool** mutatedPoints;
            mutatedPoints = new bool* [this->height];
            for (int i = 0; i < this->height; i++) {
                mutatedPoints[i] = new bool [this->width];
                for (int j = 0; j < this->width; j++) {
                    mutatedPoints[i][j] = this->getMutatedPoint(j, i);
                }
            }
            return mutatedPoints;
        }


        bool getMutatedPoint(int x, int y) {
            int aliveNeighbours = this->countAliveNeighbours(x, y);
            bool alive = (this->points[y][x] == 1);
            return ((alive && (aliveNeighbours == 2)) || (aliveNeighbours == 3));
        }


        int countAliveNeighbours(int x, int y) {
            int aliveCount = 0;
            for (int i = y - 1; ((i <= y + 1) && (i < this->height)); i++) {
                for (int j = x - 1; ((j <= x + 1) && (j < this->width)); j++) {
                    if (
                        i >= 0 && j >= 0
                        && (i != y || j != x)
                    ) {
                        aliveCount += int(this->points[i][j]);
                    }
                }
            }
            return aliveCount;
        }


        bool** generatePoints() {
            bool** points;
            points = new bool* [height];
            for (int i = 0; i < this->height; i++) {
                points[i] = new bool [width];
                for (int j = 0; j < this->width; j++) {
                    points[i][j] = bool(rand() % 2);
                }            
            }
            return points;
        }
};


int main() {
    std::cout << "==start\n";
    srand(time(NULL));


    const int width = 10;
    const int height = 10;
    
    Field gameField = Field(width, height);

    gameField.play();

	std::cout << "==end\n";
    std::cout << std::endl;
    return 0;
}
