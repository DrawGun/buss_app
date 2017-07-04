class TripFilter extends React.Component {
  constructor(props) {
    super(props);

    const { value } = this.props;
    this.state = { value: value };

    this._setFilter = this._setFilter.bind(this);
  }

  render() {
    const options = this.getOptions();

    return (
      <div className="trips-filters panel panel-default">
        <div className="panel-body">
          { options }
        </div>
      </div>
    )
  }

  getOptions() {
    const { options, loading } = this.props;

    return _.map(
      options,
      (arr) => (
        <label className="checkbox-inline" key={arr[0]}>
          <input
            type="checkbox"
            value={arr[0]}
            onChange={this._setFilter}
            checked={this.isCheckboxChecked(arr[0])}
            disabled={loading} /> {arr[1]}

        </label>
      )
    );
  }

  isCheckboxChecked(value) {
    let valueArray = _.split(this.state.value, ',');
    return _.includes(valueArray, value);
  }

  _setFilter(event) {
    const checkbox_value = event.target.value;
    let valueArray = _.split(this.state.value, ',');

    if (_.includes(valueArray, checkbox_value)) {
      const index = _.findIndex(valueArray, function(v) { return v == checkbox_value; });
      valueArray.splice(index, 1);
    } else {
      valueArray = valueArray.concat([checkbox_value]);
    };

    valueArray = _.compact(valueArray);

    this.setState({ value: _.join(valueArray, ',') }, function() {
      this.props.setFilter({value: this.state.value})
    });
  }


}

TripFilter.propTypes = {
  loading: React.PropTypes.bool,
  options: React.PropTypes.array,
  setFilter: React.PropTypes.func,
  value:  React.PropTypes.string
};
