class TripsBox extends React.Component {
  constructor(props) {
    super(props);

    const { default_value } = this.props;
    this.state = { value: default_value, page: 1, trips: [] };

    this._setFilter = this._setFilter.bind(this);
    this.setTrips();
  }

  render() {
    const { filter_options, default_value } = this.props;
    const { value } = this.state;

    return (
      <div className="trips-section">
        <TripFilter
          options={filter_options}
          value={value}
          setFilter={this._setFilter} />

       {this.state.trips && this.renderTrips()}
       {this.state.trips && this.renderLoadMoreButton()}
      </div>
    )
  }

  renderTrips() {
    const { trips } = this.state
    return (
      <div className="trips-list">
        <Trips
          trips={trips} />
      </div>
    );
  }

  renderLoadMoreButton() {
    return (
      <div className="liad-more-trips">

      </div>
    );
  }

  _setFilter(hash) {
    this.setState(hash, this.setTrips);
  }

  setTrips() {
    const self = this;
    const { value, page } = this.state;

    jQuery.ajax({
        type: "GET",
        url: `/trip_items?filter=${value}&page=${page}`,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data){
          // const trips = _.concat(self.state.trips, data)
          // self.setState({trips: trips});
          self.setState({trips: self.state.trips.concat(data)});
        },
        failure: function(errMsg) {
          console.log(errMsg);
        }
    });
  }
}
