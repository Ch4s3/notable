import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import ApolloClient, { createNetworkInterface } from 'apollo-client';
import { graphql, ApolloProvider } from 'react-apollo';
import gql from 'graphql-tag';
import DocsList from './components/docList.jsx'
import AnnotationPopUp from './components/annotationPopUp.jsx'
require('./apolloClientSetup.js');

const networkInterface = createNetworkInterface({
  uri: '/graph',
  opts: {
    credentials: 'same-origin',
  }
});

const client = new ApolloClient({
  networkInterface,
});


const docsListQuery = gql`
 query{
   documentsDocs{
    id
    title
    body
    annotations {
      id
    }
   }
 }`;

// let clientPromise = client.query({query: docsListQuery})

const DocsListWithData = graphql(docsListQuery)(DocsList);
class App extends Component {

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Articles</h2>
        </div>
        <ApolloProvider client={client}>
          <DocsListWithData />
        </ApolloProvider>
        <AnnotationPopUp/>
      </div>
    );
  }
 }

ReactDOM.render(
  <App></App>,
  document.getElementById('root')
);
