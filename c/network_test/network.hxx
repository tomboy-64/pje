template< typename T >
Edge<T>::Edge( Node<T>* fst, Node<T>* snd, const T& w ) : vertices { fst, snd }, weight ( w )
{
  // this "registers" our edge with its corresponding nodes
  vertices[0] -> connections.push_back( this );
  vertices[0] -> ref_ctr++;
  vertices[1] -> connections.push_back( this );
  vertices[1] -> ref_ctr++;

#ifndef NDEBUG
  std::cerr << "Registered edge (" << fst->index
    << "," << snd->index << ") with weight " << w
    << "." << std::endl;
  std::cerr << this << " " << vertices[0]->connections.back()
    << " " << vertices[1]->connections.back() << std::endl;
#endif

};

// dtor needs to clean up references (ptrs) in associated nodes
template< typename T >
Edge<T>::~Edge()
{
#ifndef NDEBUG
  std::cerr << "Deleting pointers to Edge " << weight
    << " in Nodes " << vertices[0]->index << " and "
    << vertices[1]->index << " ... ";
#endif

  size_t del_ref_cnt = 0;

  for( short v : {0,1} )
  {
    for( typename std::list<Edge<T>*>::iterator it = vertices[v]->connections.begin();
        it != vertices[v]->connections.end();
        it++ )
    {
      if( *it == this )
      {
        del_ref_cnt++;
        vertices[v]->connections.erase( it );
        vertices[v]->ref_ctr--;
        break;
      }
    }
  }

#ifdef NDEBUG
  if( del_ref_cnt != 2 )
  {
#endif

    std::cerr << " @ (" << vertices[0] << "," << vertices[1]
      << "); deleted " << del_ref_cnt << " which should be 2." << std::endl;

#ifdef NDEBUG
  }
#endif

}

template< typename T >
Node<T>::Node( const size_t& idx ) : index ( idx ), ref_ctr { 0 }
{
#ifndef NDEBUG
  std::cerr << "Constructed Node " << idx << std::endl;
#endif
};

template< typename T >
Node<T>::~Node()
{
  // All Edges are created on the heap;
  // hence they need to be cleaned up manually.
  // This should only happen when our containing object (network) gets destroyed.
  typename std::list<Edge<T>*>::iterator it = connections.begin();
  while( it != connections.end() )
  {
    delete *it;
    it = connections.begin(); // After every delete our std::list iterators get invalidated.
  }

#ifndef NDEBUG
  std::cerr << "Deleted Node " << index << " and all associated Edges." << std::endl;
#endif

}

template< typename T, size_t D >
Network<T,D>::Network()
{
  for( size_t i = 0; i < D; i++ )
    network[i] = new Node<T>( i );
}

template< typename T, size_t D >
Network<T,D>::~Network()
{
  for( size_t i = 0; i < D; i++ )
  {
    std::cerr << "Commencing deletion of network[" << i << "] ... " << std::endl;
    delete network[i];
    std::cerr << "Deleted network[" << i << "]" << std::endl;
  }
}

template< typename T, size_t D >
bool Network<T,D>::exists_edge( const size_t& v1, const size_t& v2 )
{
  for( typename std::list<Edge<T>*>::const_iterator cit = network[v1]->connections.cbegin();
      cit != network[v1]->connections.cend();
      cit++ )
  {
    if( ((*cit)->vertices[0] == network[v2])
        || ((*cit)->vertices[1] == network[v2]) )
    {
      return true;
    }
  }
  return false;
}

template< typename T, size_t D >
bool Network<T,D>::add_edge( const size_t& v1, const size_t& v2, const T& w )
{
  if( exists_edge( v1, v2 ) )
  {
    std::cerr << "Warning: edge (" << v1 << "," << v2 << ") exists. Skipping addition of " << w << "." << std::endl;
    return false;
  }
  else
  {
    // the new Edge registers itself with its vertices
    new Edge<T>( network[v1], network[v2], w );
    return true;
  }
}

template< typename T, size_t D >
bool Network<T,D>::remove_edge( const size_t& v1, const size_t& v2 )
{
  if( exists_edge( v1, v2 ) )
  {
    for( typename std::list<Edge<T>*>::iterator it = network[v1]->connections.begin();
        it != network[v1]->connections.end();
        it++ )
    {
      if( ((*it)->vertices[0] == network[v2])
          || ((*it)->vertices[1] == network[v2]) )
      {
        delete *it;
        return true;
      }
    }
    std::cerr << "Warning: Edge (" << v1 << "," << v2 << ") apparently exists but could not be found for deletion." << std::endl;
  }
  else
  {
    std::cerr << "Warning: Edge (" << v1 << "," << v2 << ") does not exist. Skipping deletion." << std::endl;
  }
  return false;
}

template< typename T, size_t D >
T* Network<T,D>::get_weight( const size_t& v1, const size_t& v2 )
{
  for( typename std::list<Edge<T>*>::const_iterator cit = network[v1]->connections.cbegin();
      cit != network[v1]->connections.cend();
      cit++ )
  {
    if( ((*cit)->vertices[0] == network[v2])
        || ((*cit)->vertices[1] == network[v2]) )
    {
      return &((*cit)->weight);
    }
  }
  return nullptr;
}
