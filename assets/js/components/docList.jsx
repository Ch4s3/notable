import React, { Component } from 'react';
import ReactDOM from 'react-dom';

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
     { documentsDocs.map( doc => <li key={doc.id}><div data-doc-id={doc.id}><h4>{doc.title}</h4><p>{doc.body}</p></div></li>) };
    </ul>;
  }
}
