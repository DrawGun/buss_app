class TripsBox extends React.Component {
  constructor(props) {
    super(props);

    const { value, trips, loading } = this.props;
    this.state = { value: value, trips: trips, loading: loading };

    this._setFilter = this._setFilter.bind(this);
    this.setTrips();
  };

  render() {
    const { filter_options, default_value } = this.props;
    const { value, loading } = this.state;

    return (
      <div className="trips-section">
        <TripFilter
          options={filter_options}
          value={value}
          setFilter={this._setFilter}
          loading={loading} />

       {this.state.trips && !this.state.loading && this.renderTrips()}
       {this.state.loading && this.renderSpinner()}
      </div>
    )
  };

  renderTrips() {
    const { trips } = this.state
    return (
      <div className="trips-list">
        <Trips
          trips={trips} />
      </div>
    );
  };

  renderSpinner(){
    return (
      <div className="trips-spinner text-center">
        <i className="fa fa-spinner fa-spin fa-5x"></i>
      </div>
    );
  };

  _setFilter(hash) {
    const state_hash = _.merge({ loading: true }, hash);
    this.setState(state_hash, this.setTrips);
  };

  setTrips() {
    const self = this;
    const { value, trips } = this.state;

    jQuery.ajax({
        type: "GET",
        url: `/trips?filter=${value}`,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data, textStatus, request){
          self.setState({trips: data, loading: false});
        },
        failure: function(errMsg) {
          console.log(errMsg);
        }
    });
  };
}

TripsBox.defaultProps = {
  value: "all",
  trips: [],
  loading: true
};

TripsBox.propTypes = {
  filter_options: React.PropTypes.array,
  loading: React.PropTypes.bool,
  trips: React.PropTypes.array,
  value:  React.PropTypes.string
};
