# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  phone                  :string(255)
#  address                :string(255)
#  name                   :string(255)
#

class User < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :organizations, through: :members
  has_many :events, through: :members
  has_many :teams, through: :members
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {in: 2..40}
  validates_format_of :phone,
    :unless => Proc.new { |user| user.phone.blank? },
    :with => /[0-9]{3}-[0-9]{3}-[0-9]{4}/,
    :message => "- Phone numbers must be in xxx-xxx-xxxx format."

end
