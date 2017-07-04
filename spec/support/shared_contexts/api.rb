shared_context "Application JSON headers", :json_headers do
  before do
    request.headers.merge!("Content-Type" => "application/json",
                           "Accept" => "application/json")
  end
end
