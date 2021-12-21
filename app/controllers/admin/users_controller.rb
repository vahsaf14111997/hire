class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @date_from = (params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d")
    @date_to = (params[:date_to].present?) ? params[:date_to] : ((params[:date_from].present?) ? params[:date_from] : Date.today.strftime("%Y-%m-%d"))
    date_range = @date_from.to_date.at_beginning_of_day... @date_to.to_date.at_end_of_day

    @users = User.where(user_type: "candidate", created_at: date_range).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)

    mail_data = ({
      name: create_user_params[:name],
      email: create_user_params[:email],
      password: create_user_params[:password],
      test_link: "https://hiring.spritle.com"
    }).to_json

    respond_to do |format|
      if @user.save
        UserMailer.send_email(mail_data).deliver_now!

        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy

    Result.where(user_id: @user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
    end
  end

  def import
  end

  def bulk_upload
    User.import(params[:file])
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_user_params
      params.require(:user).permit(:name, :email, :mobile, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :email, :mobile, :status, :took_test)
    end
end
