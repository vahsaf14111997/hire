class Admin::DashboardController < ApplicationController
  def index
    @test_sent_overall = User.where(user_type: "candidate").count
    @test_took_overall = User.where(user_type: "candidate", took_test: true).count
    @test_sent_today = User.where(user_type: "candidate").where("created_at > ? ", Date.today.beginning_of_day()).count
    @test_took_today = User.where(user_type: "candidate", took_test: true).where("created_at > ? ", Date.today.beginning_of_day()).count

    date_range = Date.today.at_beginning_of_day... Date.today.at_end_of_day
    @recent_users = User.where(created_at: date_range, user_type: "candidate").limit(80).order("created_at DESC")
    @recent_tests = Result.includes(:user).where(updated_at: date_range, "user.user_type": "candidate", "user.took_test": true).limit(20).order("results.updated_at DESC")

    update_status
  end

  def update_status
    users = User.where(user_type: "candidate", took_test: false)
    current_day = Date.today.strftime("%d-%m-%Y").to_date

    users.each do |user|
      created_day = user.created_at.strftime("%d-%m-%Y").to_date
      diff = (current_day - created_day).to_i

      if diff > 5
        user.update_column(:status, "test_not_taken")
      end
    end
  end
end
