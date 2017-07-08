class Trips extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const trips = this.prepareTrips();

    return (
      <div>
        { trips }
      </div>
    )
  }

  prepareTrips() {
    const { trips } = this.props;

    return _.map(
      trips,
      (trip) => (
        <table className="table table-striped table-hover table-bordered" key={trip.key}>
          <thead>
            <tr className="row">
              <th colSpan="5" className="col-md-12">{ trip.direction }</th>
            </tr>
          </thead>
          <tbody>
            { this.prepareTripItemss(trip.trips) }
          </tbody>
        </table>
      )
    );
  }

  prepareTripItemss(trips) {
    return _.map(
      trips,
      (trip) => (
        <tr key={trip.id} className="row">
          <td className="col-md-5">{trip.trip}</td>
          <td className="col-md-2">{trip.time}</td>
          <td className="col-md-2">{trip.activity}</td>
          <td className="col-md-1">{trip.total_cost}</td>
          <td className="col-md-2">{trip.carrier}</td>
        </tr>
      )
    );
  }
}

Trips.propTypes = {
  trips: React.PropTypes.array
};
