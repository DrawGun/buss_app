class Site::WelcomeController < Site::BaseController
  before_action :set_filter_options

  private

  def set_filter_options
    @filter_options = Trip::SCHEDULE.to_a.unshift([:all, "Ежедневно"])
  end
end
