# FastReplaceBenchmarks

These are some benchmarks for [FastReplace](https://github.com/stefanspringer1/FastReplace), also using using the [CodepointMacro](https://github.com/stefanspringer1/CodepointMacro), with comparisons to the usual replacement operations.

For replacements with singletons, the number of runs is 10 times as high. You can give the number of runs for non-singletons as the first argument to the application, else its number is 1000.

Note that the different runs are not interlocked, so keep the system stable while running the benchmarks.

Note: There might be room for improvements, or – dependant on the Swift version – some “fast replace” methods might not be sensible.

Sample outputs:

Swift 6.0.0 on macOS 14.6.1 (M1 MacBook Pro):

```text
                        | # runs |      characters     |       scalars       |      codepoints    
------------------------|--------|---------------------|---------------------|---------------------
single to single        |  10000 | 5.941001125 seconds | 0.243816583 seconds | 0.04072525 seconds 
------------------------|--------|---------------------|---------------------|---------------------
single to String        |  10000 | 5.933610959 seconds | 0.271967166 seconds | 0.27210825 seconds 
------------------------|--------|---------------------|---------------------|---------------------
several, each to single |   1000 | 2.406665958 seconds | 0.027939083 seconds | 0.00591075 seconds 
------------------------|--------|---------------------|---------------------|---------------------
several, each to String |   1000 | 2.582032375 seconds | 0.035463625 seconds | 0.034445084 seconds
------------------------|--------|---------------------|---------------------|---------------------


                                                   | replacement of a single letter via regular expression (1000 runs)
---------------------------------------------------|-------------------------------------------------------------------
regex in function                                  | 4.062840625 seconds
duration global regex                              | 3.958226042 seconds
duration regex in function with codepoint matching | 4.029145791 seconds
duration global regex with codepoint matching      | 3.95655525 seconds
```

Swift 6.0.2 on Windows 11 (8-core i7, 2.3 Ghz):

                        | # runs |     characters    |      scalars      |     codepoints
------------------------|--------|-------------------|-------------------|-------------------
single to single        |  10000 | 0.2724426 seconds | 0.4719126 seconds | 0.176226 seconds
------------------------|--------|-------------------|-------------------|-------------------
single to String        |  10000 | 0.2091328 seconds | 0.5358673 seconds | 0.5633636 seconds
------------------------|--------|-------------------|-------------------|-------------------
several, each to single |   1000 | 0.1444757 seconds | 0.042567 seconds  | 0.0255775 seconds
------------------------|--------|-------------------|-------------------|-------------------
several, each to String |   1000 | 0.1563129 seconds | 0.0616341 seconds | 0.0571144 seconds
------------------------|--------|-------------------|-------------------|-------------------


                                                   | replacement of a single letter via regular expression (1000 runs)
---------------------------------------------------|-------------------------------------------------------------------
regex in function                                  | 3.1188832 seconds
duration global regex                              | 2.8759167 seconds
duration regex in function with codepoint matching | 3.4034568 seconds
duration global regex with codepoint matching      | 3.5267184 seconds
