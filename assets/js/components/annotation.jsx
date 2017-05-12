import React, { Component } from 'react';
import ReactDOM from 'react-dom';

export default class Annotation extends React.Component {
  render() {
    const { data: { refetch, loading, error, documentsAnnotation } } = this.props;
    if (loading) {
     return <p>Loading ...</p>
    }
    if (error) {
     return <p>{error.message}</p>
    }

    const text = documentsAnnotation.text
    return (
      <div key={1}>
        {text}
      </div>
    );
  }
}
