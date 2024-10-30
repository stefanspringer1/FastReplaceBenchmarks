# FastReplaceBenchmarks

These are some benchmarks for [FastReplace](https://github.com/stefanspringer1/FastReplace), also using using the [CodepointMacro](https://github.com/stefanspringer1/CodepointMacro), with comparisons to the usual replacement operations.

For replacements with singletons, the number of runs is 10 times as high. You can give the number of runs for non-singletons as the forst argument to the application, else its number is 1000.

Note that the different runs are not interlocked, so keep the system stable while running the benchmarks.

Sample output:

```text
                        | # runs |         characters        |          scalars          |         codepoints       
------------------------|--------|---------------------------|---------------------------|---------------------------
single to single        |  10000 | 6.109593833 seconds       | 0.253927541 seconds       | 0.041686375 seconds      
------------------------|--------|---------------------------|---------------------------|---------------------------
single to String        |  10000 | 6.070718124999999 seconds | 0.283666833 seconds       | 0.283578792 seconds      
------------------------|--------|---------------------------|---------------------------|---------------------------
several, each to single |   1000 | 2.422731916 seconds       | 0.028508208 seconds       | 0.006003542 seconds      
------------------------|--------|---------------------------|---------------------------|---------------------------
several, each to String |   1000 | 2.589876833 seconds       | 0.037269292 seconds       | 0.03571975 seconds       
------------------------|--------|---------------------------|---------------------------|---------------------------
```
