class Admin::ResultsController < ApplicationController
  def index
    @date_from = (params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d")
    @date_to = (params[:date_to].present?) ? params[:date_to] : ((params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d"))
    date_range = @date_from.to_date.at_beginning_of_day... @date_to.to_date.at_end_of_day

    @results = Result.includes(:user).where("user.user_type": "candidate", "user.took_test": true, updated_at: date_range).order("results.updated_at DESC")
    p @results.to_json

    if params[:type] == 'excel'
      @sheet_name = "All Candidates Results"
      render xlsx: "all_candidates_results", template: "admin/results/export_result.xlsx.axlsx"
    end
  end

  def active_list
    @date_from = (params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d")
    @date_to = (params[:date_to].present?) ? params[:date_to] : ((params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d"))
    date_range = @date_from.to_date.at_beginning_of_day... @date_to.to_date.at_end_of_day

    @results = Result.includes(:user).where("user.user_type": "candidate", "user.took_test": true, updated_at: date_range).where("percentage >= ?", 40).order("results.updated_at DESC")

    if params[:type] == 'excel'
      @sheet_name = "Active Candidates Results"
      render xlsx: "active_candidates_results", template: "admin/results/export_result.xlsx.axlsx"
    end
  end

  def rejected_list
    @date_from = (params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d")
    @date_to = (params[:date_to].present?) ? params[:date_to] : ((params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d"))
    date_range = @date_from.to_date.at_beginning_of_day... @date_to.to_date.at_end_of_day

    @results = Result.includes(:user).where("user.user_type": "candidate", "user.took_test": true, updated_at: date_range).where("percentage < ?", 40).order("results.updated_at DESC")

    if params[:type] == 'excel'
      @sheet_name = "Rejected Candidates Results"
      render xlsx: "rejected_candidates_results", template: "admin/results/export_result.xlsx.axlsx"
    end
  end
end
