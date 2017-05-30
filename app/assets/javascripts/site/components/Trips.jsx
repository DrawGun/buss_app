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
            <th>Дата начала поездки</th>
            <th>Место отправления</th>
            <th>Дата окончания поездки</th>
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
          <td>{trip.start_date_str}</td>
          <td>{trip.trip_start_point}</td>
          <td>{trip.end_date_str}</td>
          <td>{trip.trip_end_point}</td>
          <td>{trip.trip_carrier_name}</td>
          <td>{trip.total_sum}</td>
          <td>{trip.trip_activity}</td>
        </tr>
      )
    );
  }
}
