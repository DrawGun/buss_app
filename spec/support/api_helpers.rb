module ApiHelpers
  def raw_json
    @raw_json ||= response.body
  end

  def parsed_json
    @parsed_json ||= JSON.parse(raw_json)
  end

  def json
    @json ||= parsed_json.to_hashugar
  end

  def symbolized_json
    @symbolized_json ||= JSON.parse(raw_json, symbolize_names: true)
  end

  def index_trip_ids
    @index_trip_ids ||= symbolized_json.map { |h| h[:trips] }.flatten.map { |h| h[:id] }
  end
end
