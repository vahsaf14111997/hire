class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  after_save :change_user_status

  has_one :result

  def self.import(file)
    data = Roo::Excelx.new(file.tempfile)
    headers = data.row(1)

    data.each_with_index do |row, idx|
      next if idx == 0

      user_data = Hash[[headers, row].transpose]
      user_data = user_data.map { |k, v| [k ? (k.class == "String" ? k.strip : k) : k, v ? (v.class == "String" ? v.strip : v) : v] }.to_h

      User.create(user_data)

      mail_data = ({
        name: user_data["name"],
        email: user_data["email"],
        password: user_data["password"],
        test_link: "https://hiring.spritle.com"
      }).to_json

      UserMailer.send_email(mail_data).deliver_now!
    end
  end

  def is_admin?
    self.user_type == "admin"
  end

  def is_candidate?
    self.user_type == "candidate"
  end

  private
    def change_user_status
      (self.took_test == true) ? (self.update_column(:status, "test_taken")) : (self.update_column(:status, "test_sent"))

      if self.took_test == false
        Result.where(user_id: self.id).destroy_all
      end
    end
end
