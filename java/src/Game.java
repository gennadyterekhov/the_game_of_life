public class Game {
    public static String aliveStr;
    public static String deadStr;
    private int width;
    private int height;
    private int timeout;
    private Field field;

    public Game(int height, int width) {
        this.height = height;
        this.width = width;
        this.field = new Field(this.height, this.width);
    }
    
    public Game(Config config) {
        this.height = config.height;
        this.width = config.width;
        this.timeout = config.timeout;
        Game.aliveStr = config.aliveStr;
        Game.deadStr = config.deadStr;

        this.field = new Field(this.height, this.width);
    }

    public void play() {
        for (int i = 0; true; ++i) {
            System.out.printf("\n\nIteration %d\n\n", i);
            System.out.println(field.toString());

            this.field.update();

            this.waitTimeout();
        }
    }

    private void waitTimeout() {
        try {
            Thread.sleep(this.timeout);
        } catch (Exception exception) {

        }
    }
}