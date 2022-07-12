import java.util.HashMap;
import java.util.Map;

public class CliArgumentsProcessor {
    private static final String HEIGHT_OPTION = "--height=";
    private static final String WIDTH_OPTION = "--width=";
    private static final String ALIVE_STR_OPTION = "--alive-str=";
    private static final String DEAD_STR_OPTION = "--dead-str=";
    private static final String TIMEOUT_OPTION = "--timeout=";


    private static final HashMap<String, String> OPTIONS_TO_FIELDS_MAP = new HashMap<String, String>(
        Map.of(
            CliArgumentsProcessor.HEIGHT_OPTION, "height",
            CliArgumentsProcessor.WIDTH_OPTION, "width",
            CliArgumentsProcessor.ALIVE_STR_OPTION, "aliveStr",
            CliArgumentsProcessor.DEAD_STR_OPTION, "deadStr",
            CliArgumentsProcessor.TIMEOUT_OPTION, "timeout"
        )
    );

    public static CliArguments processCliArgs(String[] args) {        
        CliArguments cliArguments = new CliArguments();

        for(int i = 0; i < args.length; ++i) {
            System.out.println(args[i]);

            String option = CliArgumentsProcessor.getOptionOrNull(args[i]);

            if (option == null) {
                continue;
            }

            String fieldName = CliArgumentsProcessor.OPTIONS_TO_FIELDS_MAP.get(option);

            String argumentValue = CliArgumentsProcessor.getArgumentValue(args[i], option);

            cliArguments.addArgument(fieldName, argumentValue);
        }

        return cliArguments;
    }


    private static String getOptionOrNull(String arg) {
        if (arg.indexOf(CliArgumentsProcessor.HEIGHT_OPTION) == 0) {
            return CliArgumentsProcessor.HEIGHT_OPTION;
        }
        if (arg.indexOf(CliArgumentsProcessor.WIDTH_OPTION) == 0) {
            return CliArgumentsProcessor.WIDTH_OPTION;
        }
        if (arg.indexOf(CliArgumentsProcessor.ALIVE_STR_OPTION) == 0) {
            return CliArgumentsProcessor.ALIVE_STR_OPTION;
        }
        if (arg.indexOf(CliArgumentsProcessor.DEAD_STR_OPTION) == 0) {
            return CliArgumentsProcessor.DEAD_STR_OPTION;
        }
        if (arg.indexOf(CliArgumentsProcessor.TIMEOUT_OPTION) == 0) {
            return CliArgumentsProcessor.TIMEOUT_OPTION;
        }
        return null;
    }

    private static String getArgumentValue(String rawArgument, String option) {
        int optionLength = option.length();
        
        return rawArgument.substring(optionLength);
    }
}
