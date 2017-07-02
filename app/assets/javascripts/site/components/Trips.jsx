class Trips extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const trips = this.prepareTrips();

    return (
      <table className="table table-striped table-hover table-bordered">
        <thead>
          <tr>
            <th>Время начала поездки</th>
            <th>Место отправления</th>
            <th>Время окончания поездки</th>
            <th>Место прибытия</th>
            <th>Перевозчик</th>
            <th>Стоимость</th>
            <th>График движения</th>
          </tr>
        </thead>
        <tbody>
          {trips}
        </tbody>
      </table>
    )
  }

  prepareTrips() {
    const { trips } = this.props;

    return _.map(
      trips,
      (trip) => (
        <tr key={trip.id}>
          <td>{trip.start_time}</td>
          <td>{trip.start_point}</td>
          <td>{trip.end_time}</td>
          <td>{trip.end_point}</td>
          <td>{trip.carrier_name}</td>
          <td>{trip.total_sum}</td>
          <td>{trip.activity}</td>
        </tr>
      )
    );
  }
}

Trips.propTypes = {
  trips: React.PropTypes.array
};
