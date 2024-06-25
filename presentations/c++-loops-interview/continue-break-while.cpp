#include <iostream>

int main() {
  int n = 0;
  while(true)
  {
    n++;
    if (n == 4)
    {
      continue; // <-- skip back to the start of the loop
    }
    std::cout << "Counting..." << n << "\n";
    if (n == 10)
    {
      break; // <-- exit the loop, resume control flow
    }
  }
  return 0;
}
