import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import Document from './document.jsx'
export default class DocsList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { data: { refetch, loading, error, documentsDocs } } = this.props;
    if (loading) {
     return <p>Loading ...</p>
    }
    if (error) {
     return <p>{error.message}</p>
    }
    return (
      <div>
        <button onClick={() => refetch()}>
          Reload
        </button>
        <ul>
         { documentsDocs.map( doc =>
           <div key={doc.id}>
             <Document document={doc}
               clickAnnotationHighlight={this.props.clickAnnotationHighlight}
             />
           </div>)}
        </ul>
      </div>)
  }
}
