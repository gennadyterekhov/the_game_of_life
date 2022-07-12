# Java

Java implementation  

## how to run

compile into `TheGameOfLife.class`:  
`javac -d bin src/*.java`

run:  
`cd bin`
`java TheGameOfLife`
  
  
or the same in one line:  
`javac -d bin src/*.java && cd bin && java TheGameOfLife && cd ../`

### cli arguments

possible arguments are:  
- --height
- --width
- --alive-str
- --dead-str
- --timeout

example:  

`java TheGameOfLife --height=10 --width=20 --alive-str=+ --dead-str=- --timeout=100`
