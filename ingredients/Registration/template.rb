def create_registrations_controller
  generate :controller, 'Registrations'

  inject_into_file 'app/controllers/registrations_controller.rb',
    <<~SNIPPET_1,
allow_unauthenticated_access only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for(@user)
      redirect_to root_url, notice: "Registered successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
SNIPPET_1
after: "class RegistrationsController < ApplicationController\n"
end

def add_routes
  route('resource :registration, only: [ :new, :create ]')
end

def add_user_validations
  inject_into_file 'app/models/user.rb',
    "validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }",
    after: "normalizes :email_address, with: -> e { e.strip.downcase }\n"
end

create_registrations_controller
add_routes
add_user_validations