import React, { Component } from 'react';
import ReactDOM from 'react-dom';

export default class Document extends React.Component {
  render() {
    function highlightBody(body, annotations, docID){
      if(annotations.length > 0){
        var length = 0;
        let markedBody = annotations.map((annotation, index) => {
          let start = annotation.startChar;
          let end = annotation.endChar;
          let beforeMark = body.slice(length, start)
          let after = ''
          let markedText = body.slice(start, end)
          if (index === annotations.length){
            after = body.slice(end, body.length)
          }
          length = beforeMark.length + markedText.length + after.length
          let key = docID + '-' + index + '-' + length
          return(<span key={key}>{beforeMark}<mark>{markedText}</mark>{after}</span>)
        })

        return (<p>{markedBody}</p>)
      }else{return(<p>body</p>)}
    }

    const body = highlightBody(this.props.document.body, this.props.document.annotations, this.props.document.docID)
    return (
      <div data-doc-id={this.props.document.id}>
        <h4>{this.props.document.title}</h4>
        {body}
      </div>
    );
  }
}
