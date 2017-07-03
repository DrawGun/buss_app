class TripsBox extends React.Component {
  constructor(props) {
    super(props);

    const { value, trips, page, loading } = this.props;
    this.state = { value: value, trips: trips, page: page, loading: loading };

    this._setFilter = this._setFilter.bind(this);
    this._loadMore = this._loadMore.bind(this);
    this.setTrips();
  };

  render() {
    const { filter_options, default_value } = this.props;
    const { value, loading, showMoreButtonDisabled } = this.state;

    return (
      <div className="trips-section">
        <TripFilter
          options={filter_options}
          value={value}
          setFilter={this._setFilter}
          loading={loading} />

       {this.state.trips && (!this.state.loading || this.state.page != 1) && this.renderTrips()}
       {this.state.trips && !this.state.loading && !this.state.showMoreButtonDisabled && this.renderLoadMoreButton()}
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

  renderLoadMoreButton() {
    return (
      <div className="liad-more-trips text-center">
        <button type="submit" className="btn btn-default" onClick={this._loadMore}>
          Загрузить еще
        </button>
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
    const state_hash = _.merge({ loading: true, page: 1 }, hash);
    this.setState(state_hash, this.setTrips);
  };

  _loadMore(){
    let { page } = this.state;
    this._setFilter({page: page + 1})
  };

  setTrips() {
    const self = this;
    const { value, page, trips } = this.state;

    jQuery.ajax({
        type: "GET",
        url: `/trips?filter=${value}&page=${page}`,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data, textStatus, request){
          let showMoreButtonDisabled = false;
          const totalTrips = parseInt(request.getResponseHeader('TOTAL_TRIPS'));

          if (trips.length + data.length == totalTrips) {
            showMoreButtonDisabled = true;
          }

          if (page == 1) {
            self.setState({trips: data, loading: false, showMoreButtonDisabled: showMoreButtonDisabled});
          } else {
            self.setState({trips: _.concat(trips, data), loading: false, showMoreButtonDisabled: showMoreButtonDisabled});
          }
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
  page: 1,
  loading: true
};

TripsBox.propTypes = {
  filter_options: React.PropTypes.array,
  loading: React.PropTypes.bool,
  page: React.PropTypes.number,
  trips: React.PropTypes.array,
  value:  React.PropTypes.string
};
