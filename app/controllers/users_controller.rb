class UsersController <ApplicationController 
  def new
    @user = User.new
  end

  def login_form; end

  def show
    # @user = User.find(params[:id])
    # @user = User.find(session[:user_id])
    if current_user
      @user = current_user
    else
      redirect_to root_path, notice: "You must be logged in or registered to access your dashboard."
    end
  end

  def login
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
    # ? not sure which create method is more suitable
    # new_user = User.create!(user_params)
    # if new_user.save
    #   redirect_to dashboard_users_path(new_user)
    #   session[:user_id] = new_user.id
    #   flash[:success] = "Welcome, #{new_user.name}!"
    # else
    #   flash[:error] = new_user.errors.full_messages.to_sentence
    #   redirect_to register_path
    # end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
