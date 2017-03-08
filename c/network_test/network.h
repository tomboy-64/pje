#ifndef _NETWORK_H_
#define _NETWORK_H_

#include <list>
#include <iostream>

template< typename T > struct Node;
template< typename T >
struct Edge
{
  // Delete copy ctor; there can only be one per edge, which cannot be copied.
  Edge( const Edge<T>& ) = delete;
  Edge( Node<T>*, Node<T>*, const T& );
  ~Edge();
  Node<T>* vertices[2];
  const T weight;
};

template< typename T >
struct Node
{
  // Delete copy ctor; each Node is unique.
  Node( const Node<T>& ) = delete;
  Node( const size_t& );
  ~Node(); // dtor needs to explicitely delete all Edges
  const size_t index;
  size_t ref_ctr;
  // Needs to be Edge*, since they can't be default initialized.
  std::list<Edge<T>*> connections;
};

template< typename T, size_t D >
class Network
{
  public:
    Network();
    ~Network();
    bool exists_edge( const size_t&, const size_t& );
    bool add_edge( const size_t&, const size_t&, const T& );
    bool remove_edge( const size_t&, const size_t& );
    T* get_weight( const size_t&, const size_t& );
    size_t get_ref_cnt( const size_t& );

  private:
    // This must be an array of pointers, since we
    // can't initialize Nodes with default ctors.
    // Downside: needs to be cleaned up on destruction.
    Node<T>* network[D];
};

#include "network.hxx"

#endif
