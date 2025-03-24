# Wallis Toolkit
multi-language multi-purpose programmatic library

# Post-metaironic Development Doctrine

1. lowercase kebab-case when possible otherwise snake_case variables and functions
2. PascalCase when dealing with classes or objects
	>typescript function-object conflation resolves to snake_case
3. never abbreviate variable names, always use succinct but informative labels
	>cant think of a name? post-metairony therefore ask chatgpt
4. parenthetic/brace computation should be inner space padded ex: ( 3 + ( 12 / 3 ) )
	>applicable to (), {}, [] ( user preference for array indexing )
4. use guard clauses whenever possible
5. seperate large behavior into small functions and intrafunction behavior by 2 newlines
6. annotate variable type if not assigned to a primitive or class
	> aka if it takes longer than $\frac12$ a second to deduce the type, write it down
7. if disregarding function return value or if void, cast function call to void or comment to ensure return values not ignored/forgotten


# Argumentation
readability is paramount  
performant code next  

readable code is usually perfomant but not all performant code is readable, in the post-metaironic age the performance gain from unreadable code does not outweigh the benefits of readable code in most scenarios  

all lower-kebab-or_snake_case creates uniform text that is easy to read en masse  
PascalCase clearly illustrates the start of each word uniformily, increasing readability compared to mixed case camelCase  

never abbreviate, even vim can autocomplete, your code should read like english  

seperate large behavior into smaller functions, for example(.ts) if a function has multiple awaits, they should themselves be smaller individual peices either you wrote or from a framework
when combining smaller behaviors, immediately consume variables to keep things clean or seperate by 2 new lines distinct categorical aspects of the code

annotate variable type if not immediately deducable by the right hand side of the assignment operator

when applicable cast to void, ensuring the return value of every function is known and not forgotten