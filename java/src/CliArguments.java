// import java.lang.reflect.Field;

public class CliArguments {
    public String height;
    public String width;
    public String aliveStr;
    public String deadStr;

    public void addArgument(String name, String value) {
        if (name == "height") {
            this.height = value;
        }
        if (name == "width") {
            this.width = value;
        }
        if (name == "aliveStr") {
            this.aliveStr = value;
        }
        if (name == "deadStr") {
            this.deadStr = value;
        }
    }
}
