import java.lang.String;
import java.util.Random;

public class Field {
    private Point[][] nextGenerationField;
    private Point[][] field;
    private int height;
    private int width;

    public Field(int height, int width) {
        this.height = height;
        this.width = width;
        this.initializeWithRandomBits();
    }

    public void initializeWithRandomBits() {
        Random random = new Random();
        this.field = new Point[this.height][this.width];
        this.nextGenerationField = new Point[this.height][this.width];
        for (int i = 0; i < this.height; i++) {
            for (int j = 0; j < this.width; j++) {
                boolean randomValue = random.nextBoolean();
                this.field[i][j] = new Point(randomValue);
                this.nextGenerationField[i][j] = new Point(randomValue);
            }
        }
    }

    public String toString() {
        String fieldString = "";
        for (int i = 0; i < this.height; i++) {
            for (int j = 0; j < this.width; j++) {
                fieldString += this.field[i][j].toString();
            }
            fieldString += '\n';
        }
        return fieldString;
    }

    public void update() {
        this.prepareNextGenerationPoints();
        this.field = this.nextGenerationField.clone();
    }

    private void prepareNextGenerationPoints() {
        for (int i = 0; i < this.height; i++) {
            for (int j = 0; j < this.width; j++) {
                this.nextGenerationField[i][j].isAlive = this.isNextGenerationPointAlive(i, j);
            }
        }
    }

    private boolean isNextGenerationPointAlive(int heightIndex, int widthIndex) {
        int aliveNeighbours = this.countAliveNeighbours(heightIndex, widthIndex);

        boolean isNextGenerationAlive = ((this.field[heightIndex][widthIndex].isAlive &&
                (aliveNeighbours == 2)) ||
                (aliveNeighbours == 3));

        return isNextGenerationAlive;
    }

    private int countAliveNeighbours(int heightIndex, int widthIndex) {
        int aliveCount = 0;
        for (int i = heightIndex - 1; i <= heightIndex + 1; i++) {
            for (int j = widthIndex - 1; j <= widthIndex + 1; j++) {
                if (this.isInside(i, j)) {
                    aliveCount += this.field[i][j].toInt();
                }
            }
        }
        aliveCount -= this.field[heightIndex][widthIndex].toInt();
        return aliveCount;
    }

    private boolean isInside(int heightIndex, int widthIndex) {
        return heightIndex >= 0 && heightIndex < this.height && widthIndex >= 0 && widthIndex < this.width;
    }
}