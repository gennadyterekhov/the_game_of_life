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
            this->timeout = timeout;
            this->aliveStr = "■ ";
            this->deadStr = "□ ";
            this->initializePoints();
        }

        ~Field() {
            delete &this->width;
            delete &this->height;
            delete &this->timeout;
            delete &this->aliveStr;
            delete &this->deadStr;
            this->uninitializePoints();
        }

        void play() {
            for (int i = 0;; i++) {
                std::cout << "\n    ITERATION " << i << std::endl;
                this->show();
                this->updatePoints();
                std::this_thread::sleep_for(std::chrono::milliseconds(this->timeout));
            }
        }    


    private:
        int width;
        int height;
        int timeout;
        bool** previousPoints;
        bool** points;
        const char* aliveStr;
        const char* deadStr;


        const char* pointToCharPtr(bool point) {
            return (point) ? this->aliveStr : this->deadStr;
        }


        void show() {
            for (int i = 0; i < this->height; i++) {
                for (int j = 0; j < this->width; j++) {
                    std::cout << this->pointToCharPtr(this->points[i][j]);
                }
                std::cout << std::endl;
            }
        }
        

        void updatePoints() {
            for (int i = 0; i < this->height; i++) {
                for (int j = 0; j < this->width; j++) {
                    this->points[i][j] = this->getMutatedPoint(j, i);
                }
            }
            for (int i = 0; i < this->height; i++) {
                for (int j = 0; j < this->width; j++) {
                    this->previousPoints[i][j] = this->points[i][j];
                }
            }
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
                        aliveCount += int(this->previousPoints[i][j]);
                    }
                }
            }
            return aliveCount;
        }


        void uninitializePoints() {
            for (int i = 0; i < this->height; i++) {
                delete[] this->points[i];
                delete[] this->previousPoints[i];           
            }
        }


        void initializePoints(bool value = false) {
            this->points = new bool* [height];
            this->previousPoints = new bool* [height];

            for (int i = 0; i < this->height; i++) {

                this->points[i] = new bool [width];
                this->previousPoints[i] = new bool [width];

                for (int j = 0; j < this->width; j++) {

                    bool temp = bool(rand() % 2); 
                    this->points[i][j] = temp;
                    this->previousPoints[i][j] = temp;
                }            
            }
        }

};


int main(int argc, char** argv) {
    const short VALID_PARAMETERS_LENGTH = 4;
    const short BASE = 10;
    int width = 10;
    int height = 10;
    int timeout = 200;

    std::cout << "Game start.\n";
    srand(time(NULL));

    if (argc < VALID_PARAMETERS_LENGTH) {
        std::cout << "No parameters supplied. Running with default configuration.\n";
    } else {
        width = std::strtol(argv[1], nullptr, BASE);
        height = std::strtol(argv[2], nullptr, BASE);
        timeout = std::strtol(argv[3], nullptr, BASE);
    }

    if (
        (width <= 0) ||
        (height <= 0) ||
        (timeout <= 0)
    ) {
        std::cout << "Received negative-or-zero value. Arguments must be higher than 0.\n";
        return 1;
    }


    Field gameField = Field(width, height, timeout);

    gameField.play();

    delete &gameField;
    
	std::cout << "Game over.\n";
    return 0;
}

