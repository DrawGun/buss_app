class TripFilter extends React.Component {
  constructor(props) {
    super(props);

    this._setFilter = this._setFilter.bind(this);
  };

  render() {
    const options = this.getOptions();
    const { value, loading } = this.props;

    return (
      <div className="trips-filters panel panel-default">
        <div className="panel-body">
          <select className="form-control" value={value} onChange={this._setFilter} disabled={loading}>
            { options }
          </select>
        </div>
      </div>
    )
  };

  getOptions() {
    const { options } = this.props;

    return _.map(
      options,
      (arr) => (
        <option key={arr[0]} value={arr[0]}>{arr[1]}</option>
      )
    );
  };

  _setFilter(event) {
    this.props.setFilter({value: event.target.value});
  };
}

TripFilter.propTypes = {
  loading: React.PropTypes.bool,
  options: React.PropTypes.array,
  setFilter: React.PropTypes.func,
  value: React.PropTypes.string
};
