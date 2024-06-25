#include <iostream>

int main() {
  int n = 5;
start: // goto label
  {
    if (n > 0) // <-- While loop condition -->
    {
      // <-- While loop statement
      std::cout << "Hello World!\n";
      n--;
      // -->
      goto start;
    }
  }
  return 0;
}
