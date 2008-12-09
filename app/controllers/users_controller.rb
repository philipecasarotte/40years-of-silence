class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # render new.rhtml
  def new
    @user = Member.new
  end
 
  def create
    logout_keeping_session!
    @user = Member.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def edit
    @user = Member.find(current_user)
  end
  
  def update
    @user = Member.find(current_user)
    if @user.update_attributes(params[:user])
      redirect_back_or_default('/')
    else
      render :action=>:new
    end
  end
  
  def recovery
    begin
      @user = Member.find_by_email(params[:user][:email])
      @user.recovery_password!
      flash[:notice] = "Password successfully changed"
    rescue
      flash[:error] = "Email not found"
    end
    
    redirect_to login_path
  end
end
