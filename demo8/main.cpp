// MIT License

// Copyright (c) 2024 CUI Xin

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#include "config.h"
#include "math/MathFunctions.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef HAVE_POW
#include <math.h>
#else
#include <MathFunctions.h>
#endif

int main(int argc, char *argv[]) {
  if (argc < 3) {
    /// print version info
    printf("%s Version %d.%d\n", argv[0], DEMO8_VERSION_MAJOR,
           DEMO8_VERSION_MINOR);
    printf("Usage: %s base exponent \n", argv[0]);
    return 1;
  }
  double base = atof(argv[1]);
  int exponent = atoi(argv[2]);

#ifdef HAVE_POW
  printf("Now we use the standard library. \n");
  double result = pow(base, exponent);
#else
  printf("Now we use our own Math library. \n");
  double result = power(base, exponent);
#endif

  printf("%g ^ %d is %g\n", base, exponent, result);
  return 0;
}