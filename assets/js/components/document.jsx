import React, { Component } from 'react';
import ReactDOM from 'react-dom';

export default class Document extends React.Component {
  constructor(props) {
    super(props);
  }

  highlightBody(body, annotations, docID, onClick){
    if(annotations.length > 0){
      const sortedAnnotations =
        annotations.map((a) => a).sort(function (a, b) {
          return( a.startChar - b.startChar )
        });
      var length = 0;
      let markedBody = sortedAnnotations.map((annotation, index) => {
        let start = annotation.startChar;
        let end = annotation.endChar;
        let beforeMark = body.slice(length, start);
        let after = '';
        let markedText = body.slice(start, end);
        if (index === annotations.length - 1){
          after = body.slice(end, body.length);
        }
        length = beforeMark.length + markedText.length + after.length;
        let key = docID + '-' + index + '-' + length;
        return(
          <span key={key}>
            {beforeMark}
            <mark onClick={() => onClick(annotation.id)}>
              {markedText}
            </mark>
            {after}
          </span>)
      })

      return (<p>{markedBody}</p>)
    }else{return(<p>body</p>)}
  }

  render() {
    const onClick = this.props.clickAnnotationHighlight
    let body = this.highlightBody(this.props.document.body, this.props.document.annotations, this.props.document.id, onClick)
    return (
      <div data-doc-id={this.props.document.id}>
        <h4>{this.props.document.title}</h4>
        {body}
      </div>
    );
  }
}
