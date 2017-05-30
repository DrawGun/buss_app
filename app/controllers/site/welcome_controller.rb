class Site::WelcomeController < Site::BaseController
  before_action :set_filter_options

  private

  def set_filter_options
    @filter_options = Trip::SCHEDULE.map { |k, v| [k, v] }.unshift(["all", "Ежедневно"])
  end
end
