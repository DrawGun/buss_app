class Site::WelcomeController < Site::BaseController
  before_action :set_filter_options

  def index
    @default_value = "all"
  end

  private

  def set_filter_options
    @filter_options = Trip::SCHEDULE.map { |k, v| [k, v] }.unshift(["all", "Ежедневно"])
  end
end
