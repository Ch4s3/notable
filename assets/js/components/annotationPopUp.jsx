import React, { Component } from 'react';
import ReactDOM from 'react-dom';

function ShowPopup(props) {
  const divStyle = {
    position: 'absolute',
    left: props.popUpData.xPos,
    top: props.popUpData.yPos,
  };
  const text = props.popUpData.selectedText
  return(
    <div style={divStyle} className="card xl-shadow">
      <p>{text}</p>
      <br/>
        <form>
        <fieldset>
          <label for="annotationField">Annotation</label>
          <textarea id="annotationField"></textarea>
          <button class="button-primary">save</button>
        </fieldset>
      </form>
      <button onClick={props.onClick}>close</button>
    </div>)
}

function NoPopup(props) {
  return <div></div>;
}


export default class AnnotationPopUp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      popUpData: {},
    };
    this.handleCloseClick = this.handleCloseClick.bind(this);
  };

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
      if(docID && text.toString() !== '') {
        _this.setState({
          popUpData: {xPos: x, yPos: y, docID: docID, selectedText: text.toString()}
        })
      }
    }
    document.onmouseup = gText;
    if (!document.all) document.captureEvents(Event.MOUSEUP);
    let popUp
    if(this.state.popUpData.docID){
      popUp = <ShowPopup popUpData={this.state.popUpData} onClick={this.handleCloseClick}/>
    } else {
      popUp = <NoPopup />
    }
    return(
      <div>{popUp}</div>
    );
  }
}
