class Admin::UsersController < ApplicationController
  before_action :authorize_admin!
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    base_scope = @current_organization.users.where.not(id: Role.joins(:users).where(roles: { name: "admin" }).select(:user_id))
  
    @users = if params[:q].present?
               base_scope.where("users.name ILIKE :q OR users.email ILIKE :q", q: "%#{params[:q]}%")
             else
               base_scope
             end
  end
  
  

  def new
    @user = User.new
  end

  def create
    @user = @current_organization.users.new(user_params)
  
    if @user.save
      @user.add_role(:member)
      redirect_to admin_users_path, notice: "User was successfully created."
    else
      render :new
    end
  end
  
  

  def edit; end

  def update
    if @user.update(user_params)
      assign_role(@user)
      redirect_to admin_users_path, notice: "User successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def assign_role(user)
    return unless user.persisted? 
   
    user.roles.destroy_all
    user.add_role(:member) if params[:user][:role].present?
  end
  

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access Denied" unless current_user.has_role?(:admin)
  end
end
