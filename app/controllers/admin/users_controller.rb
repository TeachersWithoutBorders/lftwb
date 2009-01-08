class Admin::UsersController < Admin::BaseController

  before_filter :get_user, :only => [:update, :destroy]
  
  def index
    @users = User.by_newest.paginate(:page => @page, :per_page => @per_page)
  end

  def inactive
    @user_inactive_count = User.inactive_count
    @users = User.inactive.paginate(:page => @page, :per_page => @per_page)
  end
  
  def inactive_emails
    @user_inactive_count = User.inactive_count
    @users = User.inactive
  end
  
  def activate_all
    User.activate_all
    respond_to do |format|
      format.html do
        redirect_to inactive_admin_users_path
      end
    end
  end
  
  def search
  end
  
  def do_search
    
  end
  
  def update   
     
    if is_me?(@user)
      message = _("You cannot deactivate yourself!")
    else
      if @user.force_activate!
        message = _('User has been marked as active')
      else
        message = _('User has been marked as inactive')
      end
    end
    
    activate_text = '<div class="flasherror">' + message + '</div>'
    activate_text << render_to_string(:partial => 'admin/users/activate', :locals => {:user => @user})
    
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html @user.dom_id('link'), activate_text
        end
      end
    end

  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "User '#{@user.login}' was successfully deleted."
        redirect_to admin_users_path
      end
      format.xml  { head :ok }
      format.js { render(:update){|page| page.visual_effect :fade, "#{@user.dom_id('row')}".to_sym} }
    end
  end
  
  private 
  
  def get_user
    @user = User.find_by_login(params[:id]) || User.find(params[:id])
  end
  
end
