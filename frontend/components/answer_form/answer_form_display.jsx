import React from 'react';
import { Link, withRouter } from 'react-router';

class AnswerFormDisplay extends React.Component {
	constructor(props) {
		super(props);
		this.state = { body: "", author_id: this.props.current_user.id, question_id: this.props.params.id};
		this.handleSubmit = this.handleSubmit.bind(this);
	}

	componentWillReceiveProps(newProps){
		if (newProps.route === this.props.route){
			this.state = { body: "", author_id: this.props.current_user.id, question_id: this.props.params.id};
		}
	}

	// componentDidUpdate() {
	// 	this.ensureLoggedIn();
	// }

	ensureLoggedIn() {
		if (!this.props.loggedIn) {
			this.props.router.push("/login");
		}
	}

	update(field) {
		return e => this.setState({
			[field]: e.currentTarget.value
		});
	}

	handleSubmit(e) {
      this.ensureLoggedIn();
		e.preventDefault();
		const currentQuestion = this.state;
		this.props.create(this.state);
	}

	renderErrors() {
		if (this.props.errors.length > 0){
		return(
			<ul className="errors" >
				{this.props.errors.map((error, i) => (
					<li key={`error-${i}`}>
						{error}
					</li>
				))}
			</ul>
		);}
	}

	render() {
    debugger
		return (
      <form onSubmit={this.handleSubmit} className="main-content">
        <h3>Your Answer</h3>

        {this.renderErrors()}
        <div className="question-body-input" >
          <textarea className="question-body-textarea" rows="10" onChange={this.update("body")} value={this.state.body}>
          </textarea>
        </div>
        <input type="submit" value="Post Your Question" className="submit question"/>
      </form>
    );
 	}

}

export default withRouter(AnswerFormDisplay);
