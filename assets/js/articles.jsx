import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import ApolloClient, { createNetworkInterface } from 'apollo-client';
import { graphql, ApolloProvider } from 'react-apollo';
import gql from 'graphql-tag';

const networkInterface = createNetworkInterface({
  uri: '/graph',
  opts: {
    credentials: 'same-origin',
  }
});
const exampleWare1 = {
  applyAfterware({ response }, next) {
    console.log("?????")
    next();
  }
}
networkInterface.useAfter([exampleWare1]);
const client = new ApolloClient({
  networkInterface,
});

let DocsList = (props) => {
  debugger
  return (
    <ul>
      { documentsDocs.map( doc => <li key={doc.id}>{doc.title}</li> ) }
    </ul>
  );
 };

 const docsListQuery = gql`
   query{
     documentsDocs{
      id
      title
     }
   }`;

let clientPromise = client.query({query: docsListQuery})
// p.then(onFulfilled[, onRejected]);
//
// p.then(function(value) {
//   // fulfillment
// }, function(reason) {
//   // rejection
// });
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/then
let results = clientPromise.then((results) => {
  return results
})

let docsListWithData = DocsList(results)
class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Welcome to Apollo</h2>
        </div>
        <ApolloProvider client={client}>
          <docsListWithData />
        </ApolloProvider>
      </div>
    );
  }
 }

ReactDOM.render(
  <App></App>,
  document.getElementById('root')
);
