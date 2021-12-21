module Admin::DashboardHelper
  def format_timestamp(datetime)
    date = datetime.present? ? datetime.strftime("%d-%m-%Y %I:%M %p") : ""
  end
end
