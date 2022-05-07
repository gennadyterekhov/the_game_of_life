public class TheGameOfLife {
    public static void main(String[] args) {
        System.out.println("The Game Of Life. Starting");
        Game game = new Game(20, 50);
        game.play();
        System.out.println("goodbye");
        return;
    }
}