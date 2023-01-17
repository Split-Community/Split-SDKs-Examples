import React, { Component } from "react";
import { connect } from "react-redux";
import { getTreatments } from '@splitsoftware/splitio-redux';
import { splitSdk } from '@splitsoftware/splitio-redux';


class App extends Component {
  handleSubmit = e => {
    e.preventDefault();
    const splitName = this.getSplitName.value;
    this.getSplitName.value = "";
    this.props.dispatch(getTreatments({ splitNames: [splitName] }))
  };
  render() {
    console.log(this.props.data);
    return (
      <div className="container">
        <form onSubmit={this.handleSubmit} className="form">
          <h2 className="title">Enter the Split Name</h2>
          <input
            type="text"
            placeholder="Enter Split Name"
            required
            ref={input => (this.getSplitName = input)}
          />
          <button className="button">Submit</button>
        </form>        
        {Object.keys(this.props.data.splitio.treatments).length > 0 ? (
            Object.keys(this.props.data.splitio.treatments).map(i => 
         	   <h1> Treatments: {i} ({this.props.data.splitio.treatments[i].bob.treatment})  </h1>
            )
         ) : (<h1>Store is Empty</h1>)}
      </div>
    );
  }
}

const mapStateToProps = state => {
  return {
    data: state
  };
};
export default connect(mapStateToProps)(App);