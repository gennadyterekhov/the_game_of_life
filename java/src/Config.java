public class Config {
    public int height = 20;
    public int width = 50;
    public int timeout = 500;
    public String aliveStr = "■ ";
    public String deadStr = "□ ";


    public Config(CliArguments cliArguments) {
        if (cliArguments.height != null) {
            this.height = Integer.parseInt(cliArguments.height);
        }
        if (cliArguments.width != null) {
            this.width = Integer.parseInt(cliArguments.width);
        }
        if (cliArguments.aliveStr != null) {
            this.aliveStr = cliArguments.aliveStr;
        }
        if (cliArguments.deadStr != null) {
            this.deadStr = cliArguments.deadStr;
        }
        if (cliArguments.timeout != null) {
            this.timeout = Integer.parseInt(cliArguments.timeout);
        }
    }
}
