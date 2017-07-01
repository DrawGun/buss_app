class ApplicationService < Service
  Success = Struct.new(:data) do
    def success?
      true
    end
  end

  Failure = Struct.new(:code, :message, :details) do
    def success?
      false
    end
  end

  def success(data = nil)
    Success.new(data)
  end

  def failure(code, message = nil, details = nil)
    Failure.new(code, message, details)
  end
end
