import React, { Component } from 'react';
import ReactDOM from 'react-dom';

export default class Document extends React.Component {
  render() {
    function range(lowEnd,highEnd){
      var arr = [],
      c = highEnd - lowEnd + 1;
      while ( c-- ) {
          arr[c] = highEnd--
      }
      return arr;
    }

    function highlightBody(body, annotations){
      if(annotations.length > 0){

        //TODO Still need to get multiple annotations working. Probably need a
        // no overlap constraint.
        return (<p>{body.slice(0, annotations[0].startChar)}<mark>{body.slice(annotations[0].startChar, annotations[0].endChar)}</mark>{body.slice(annotations[0].endChar)}</p>)
      }else{return(<p>body</p>)}
    }

    const body = highlightBody(this.props.document.body, this.props.document.annotations)
    return (
      <div data-doc-id={this.props.document.id}>
        <h4>{this.props.document.title}</h4>
        {body}
      </div>
    );
  }
}
