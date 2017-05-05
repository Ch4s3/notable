import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import Document from './document.jsx'
export default class DocsList extends React.Component {
  render() {
    const { data: { loading, error, documentsDocs } } = this.props;
    if (loading) {
     return <p>Loading ...</p>;
    }
    if (error) {
     return <p>{error.message}</p>;
    }
    return <ul>
     { documentsDocs.map( doc => <div key={doc.id}> <Document document={doc}/> </div>) };
    </ul>;
  }
}
