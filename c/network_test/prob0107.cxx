//#include "libs/my_utility/my_utility.h"

#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "network.h"

int main() {
  std::ifstream f("./p107_network.txt");
  if (!f.is_open())
  {
    std::cout << "Shit happens. Fix your file." << std::endl;
    exit(1);
  }

  std::string line;
  std::vector<short> parsedLine;
  parsedLine.reserve(40);
  Network<short,40> network_field = Network<short,40>();
  short line_ctr = 0, ssctr = 0, summer = 0;
  while( !f.eof() )
  {
    getline( f, line );

    parsedLine.clear();
    parsedLine.push_back(0);
    for( char i : line )
    {
      if( i == 0x2c ) // -
        parsedLine.push_back(0);
      else if( i >= 0x30 && i <= 0x39 ) // 0..9
      {
        parsedLine.back() *= 10;
        parsedLine.back() += i - 0x30;
      }
      else if( i == 0x2d ) // ,
      {
        ((void)0);
      }
      else
      {
        // We shouldn't be here
        std::cout << std::endl << "Something went wrong with parsing. Examine." << std::endl;
        exit(1);
      }
    }
    int ctr = 0;
    for( int i : parsedLine )
    {
      if( i != 0 )
      {
        network_field.add_edge( line_ctr, ctr, i );
      }
      ctr++;
    }
    line_ctr++;
    std::cout << std::endl;
  }
  network_field.remove_edge(0,1);
  network_field.remove_edge(0,3);
  network_field.add_edge( 0,3,123 );
  if( network_field.exists_edge(0,3) ) std::cerr << "0,3 exists" << std::endl;
  else std::cerr << "0,3 does not exist." << std::endl;

  delete &network_field;
  std::cout << "All iz well" << std::endl;
  exit(0);
  //std::cout << std::endl << ssctr << " / " << ctr << " are special sum sets. Their sum is " << summer << std::endl;
}
