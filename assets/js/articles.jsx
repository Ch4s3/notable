import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import ApolloClient, { createNetworkInterface } from 'apollo-client';
import { graphql, ApolloProvider } from 'react-apollo';
import gql from 'graphql-tag';
import DocsList from './components/docList.jsx'
import AnnotationPopUp from './components/annotationPopUp.jsx'
import AnnotationBar from './components/annotationBar.jsx'
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
      text
      startChar
      endChar
    }
   }
 }`;

const DocsListWithData = graphql(docsListQuery, {
  options: { fetchPolicy: 'network-only' }
})(DocsList);

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showAnnotation: false,
      annotationId: 1
    };
    this.handleAnnotationCloseClick = this.handleAnnotationCloseClick.bind(this);
    this.clickAnnotationHighlight = this.clickAnnotationHighlight.bind(this);
  };

  handleAnnotationCloseClick() {
    this.setState({showAnnotation: false});
  }
  clickAnnotationHighlight(id){
    if(id){
      this.setState({annotationId: id, showAnnotation: true});
    }
  }

  render() {
    return (
      <div className="App container">
        <div className="App-header">
          <h2>Articles</h2>
        </div>
        <div className="row">
          <div className="column column-50">
            <ApolloProvider client={client}>
              <DocsListWithData
                clickAnnotationHighlight={this.clickAnnotationHighlight}
              />
            </ApolloProvider>
          </div>
          <AnnotationBar
            showAnnotation={this.state.showAnnotation}
            annotationId={this.state.annotationId}
            handleAnnotationCloseClick={this.handleAnnotationCloseClick}
          />
          <AnnotationPopUp />
        </div>
      </div>
    );
  }
 }

ReactDOM.render(
  <App></App>,
  document.getElementById('root')
);
