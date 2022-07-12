public class TheGameOfLife {
    public static void main(String[] args) {
        System.out.println("The Game Of Life. Starting");
        
        CliArguments cliArguments = CliArgumentsProcessor.processCliArgs(args);

        Config config = new Config(cliArguments);

        Game game = new Game(config);

        game.play();
        
        System.out.println("Game Over, goodbye!");
    }
}