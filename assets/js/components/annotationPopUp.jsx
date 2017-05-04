import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import AnnotationForm from './annotationForm.jsx'

export default class AnnotationPopUp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      popUpData: {},
    };
    this.handleCloseClick = this.handleCloseClick.bind(this);
  };

  showPopup(props) {
    const divStyle = {
      position: 'absolute',
      left: props.popUpData.xPos,
      top: props.popUpData.yPos,
    };
    const text = props.popUpData.selectedText
    return(
      <div style={divStyle} className="card xl-shadow">
        <button onClick={props.onClick}>close</button>
        <p>{text}</p>
        <br/>
        <AnnotationForm popUpData={props.popUpData}/>
      </div>)
  }

  noPopup(props) {
    return <div></div>;
  }

  handleCloseClick() {
    this.setState({popUpData: {}});
  }

  render() {
    const _this = this;
    function gText(e) {
      const x = e.offsetX + 16
      const y = e.clientY + 8
      const docID = e.target.parentElement.getAttribute('data-doc-id')
      const text = (document.all) ? document.selection.createRange().text : document.getSelection();
      const startChar = document.getSelection().anchorOffset - 1
      const endChar = document.getSelection().extentOffset - 1
      if(docID && text.toString() !== '') {
        _this.setState({
          popUpData: {
            xPos: x, yPos: y,
            docID: docID,
            startChar: startChar, endChar: endChar,
            selectedText: text.toString()
          }
        })
      }
    }
    document.onmouseup = gText;
    if (!document.all) document.captureEvents(Event.MOUSEUP);
    let popUp
    if(this.state.popUpData.docID){
      popUp = this.showPopup({popUpData: this.state.popUpData, onClick: this.handleCloseClick})
    } else {
      popUp = this.noPopup()
    }
    return(
      <div>{popUp}</div>
    );
  }
}
