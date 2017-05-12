import React, { Component } from 'react';
import Annotation from './annotation.jsx'
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

const client = new ApolloClient({
  networkInterface,
});


export default class AnnotationBar extends React.Component {
  constructor(props) {
    super(props);
    this.getAnnotationBar = this.getAnnotationBar.bind(this);
  };


  showAnnotationBar(data) {
    const annotationQuery = gql`
      query{
        documentsAnnotation(id: ${data.id}){
          id
          text
          doc {
            id
          }
          user {
            id
            name
          }
        }
      }`

    const AnnotationWithData = graphql(annotationQuery, {
      options: { fetchPolicy: 'network-only' }
    })(Annotation);

    const divStyle = {
      position: 'relative',
    };

    return(
      <div className="column column-50">
        <div style={divStyle} className="">
          <button onClick={data.onClick}>close</button>
        </div>
        <ApolloProvider client={client}>
          <AnnotationWithData/>
        </ApolloProvider>
      </div>)
  }

  noAnnotationBar(props) {
    return <div></div>
  }

  getAnnotationBar(){
    if(this.props.showAnnotation){
      return(
        this.showAnnotationBar({
          id: this.props.annotationId,
          onClick: this.props.handleAnnotationCloseClick})
      );
    } else {
      return(this.noAnnotationBar());
    }
  }
  render() {

    const annotationBar = this.getAnnotationBar()
    return(
      <div>{annotationBar}</div>
    );
  }
}
