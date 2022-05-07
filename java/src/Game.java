public class Game {
    private int width;
    private int height;
    private Field field;

    public Game(int height, int width) {
        this.height = height;
        this.width = width;
        this.field = new Field(this.height, this.width);
    }

    public void play() {
        for (int i = 0; true; i++) {
            System.out.printf("\n\nIteration %d\n\n", i);
            System.out.println(field.toString());

            this.field.update();
        }
    }
}