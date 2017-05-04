import React, { Component, PropTypes } from 'react';
import { gql, graphql, ApolloProvider } from 'react-apollo';
import ApolloClient, { createNetworkInterface } from 'apollo-client';

class NewAnnotation extends Component {
  onClick(e) {
    const text = e.target.form.annotationField.value
    const docID = parseInt(this.props.popUpData.docID, 10)
    const startChar = parseInt(this.props.popUpData.startChar, 10)
    const endChar = parseInt(this.props.popUpData.endChar, 10)
    this.props.mutate({
      variables: { text: text, documentsDocsId: docID, startChar: startChar, endChar: endChar }
    })
      .then(({ data }) => {
        console.log('got data', data);
      }).catch((error) => {
        console.log('there was an error sending the query', error);
      });
  }

  render() {
    return (
      <div>
        <form>
          <fieldset>
            <label htmlFor="annotationField">Annotation</label>
            <textarea id="annotationField"></textarea>
            <button
              className="button-primary"
              onClick={this.onClick.bind(this)}>
                save
            </button>
          </fieldset>
        </form>
      </div>);
  }
}
const submitRepository = gql`
  mutation documentsAnnotation($text: String!, $documentsDocsId: Int!, $startChar: Int!, $endChar: Int!) {
    documentsAnnotation(text: $text, documentsDocsId: $documentsDocsId, startChar: $startChar, endChar: $endChar) {
      id
    }
  }
`;
const NewAnnotationWithData = graphql(submitRepository)(NewAnnotation);

const networkInterface = createNetworkInterface({
  uri: '/graph',
  opts: {
    credentials: 'same-origin',
  }
});

const client = new ApolloClient({
  networkInterface,
});

export default class AnnotationForm extends React.Component {
  render(){
    return(
      <ApolloProvider client={client}>
        <NewAnnotationWithData popUpData={this.props.popUpData}/>
      </ApolloProvider>
    );
  }
}
