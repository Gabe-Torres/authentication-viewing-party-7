class UsersController <ApplicationController 
  def new
    @user = User.new
  end

  def login_form; end

  def show
    @user = User.find(params[:id])
  end

  def login
    # require 'pry'; binding.pry
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      # redirect_to user_path(user)
    # else
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to root_path
      elsif 
        redirect_to root_path
      end
    else
      flash[:error] = "Incorrect credentials"
      render :login_form
    end
  end

  def logout
    session.clear
    redirect_to root_path
  end

  # def create
  #   user = User.new(user_params)
  #   if user.save
  #     redirect_to user_path(user)
  #   else
  #     flash[:error] = user.errors.full_messages.to_sentence
  #     redirect_to register_path
  #   end
  # end

  def create
    new_user = User.new(user_params)
    if new_user.save
      redirect_to dashboard_path(new_user)
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.name}!"
    elsif
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
