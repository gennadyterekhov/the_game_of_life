#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <thread>
#include <chrono>


class Field {
    public:
        Field(int width, int height, int timeout) {
            this->width = width;
            this->height = height;
            this->aliveStr = "■ ";
            this->deadStr = "□ ";
            this->points = this->generatePoints();
            this->timeout = timeout;
        }


        void play() {
            bool continueCondition = true;
            for (int i = 0; continueCondition; i++) {
                std::cout << "\n    ITERATION " << i << std::endl;
                this->show();
                this->points = this->getMutatedPoints();
                std::this_thread::sleep_for(std::chrono::milliseconds(this->timeout));
            }
        }    


    private:
        int width;
        int height;
        int timeout;
        bool** points;
        std::string aliveStr;
        std::string deadStr;


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


int main(int argc, char** argv) {
    const short VALID_PARAMETERS_LENGTH = 4;
    char* trash;
    int width = 10;
    int height = 10;
    int timeout = 200;

    std::cout << "Game start.\n";
    srand(time(NULL));

    if (argc < VALID_PARAMETERS_LENGTH) {
        std::cout << "No parameters supplied. Running with default configuration.\n";
    } else {
        width = std::strtol(argv[1], &trash, 10);
        height = std::strtol(argv[2], &trash, 10);
        timeout = std::strtol(argv[3], &trash, 10);
    }

    Field gameField = Field(width, height, timeout);

    gameField.play();

	std::cout << "Game over.\n";
    return 0;
}
