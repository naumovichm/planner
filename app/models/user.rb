# frozen_string_literal: true

class User < ApplicationRecord
  include UserMethods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true

  belongs_to :role

  has_many :events, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :meetings, -> { where(type: 'Meeting') }, inverse_of: :user, dependent: :destroy
  has_many :notifications, -> { where(type: 'Notification') }, inverse_of: :user, dependent: :destroy
end
