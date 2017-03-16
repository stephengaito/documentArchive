# Joy concatenative programming language based on Lists of Lists

We provide an initial implementation of a form of [Manfred von Thun's 
Joy programming 
language](http://www.latrobe.edu.au/humanities/research/research-projects/past-projects/joy-programming-language) 
which is restricted to manipulating Lists of Lists.

Our initial implementation in [Racket](https://racket-lang.org/) can be 
found in the [racket directory](racket).

Eventually, time permitting, we also intend to provide implementations 
in both [C](c) and [JoyLoL](joyLoL).

## License

The implementation of JoyLoL, contained in the [racket](racket/joylol) 
directory, is Copyright PerceptiSys Ltd (Stephen Gaito) and released 
under an [MIT License](LICENSE.txt). See the associated 
[LICENSE.txt](LICENSE.txt) file.

The instance of the CuTest framework, contined in the 
ansi-c/specs/cuTest directory, has been taken from the 
combined (notEqualsAssertions + namedSubSuites) branch of the 
GitHub project 
[stephengaito/cutest](https://github.com/stephengaito/cutest) 
forked from 
[asimjalis/cutest](https://github.com/asimjalis/cutest). As 
the CuTest framework files remain under Asim Jalis's original 
license. See the license.txt file in the ansi-c/specs/cuTest 
directory.


