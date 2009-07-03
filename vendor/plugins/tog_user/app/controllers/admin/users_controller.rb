class Admin::UsersController < Admin::BaseController        

  before_filter :find_user
  
  def index
    @order_by, @sort_order = build_order(User, :login)
    @users = User.search(params[:text]).aged(params[:age]).state(params[:state]).\
             paginate :page => params[:page],
                      :per_page => Tog::Config['plugins.tog_core.pagination_size'],
                      :order => [@order_by, @sort_order].join(" ") 
  end

  def new       
    @user = User.new(params[:user])
  end

  def create
    @user = User.new(params[:user])
    @user.make_activation_code
    @user.save!
    redirect_to(admin_users_url)
    flash[:ok] = I18n.t("tog_user.admin.user_created", :login => @user.login)
  rescue ActiveRecord::RecordInvalid
    flash[:error] = @title = I18n.t("tog_user.admin.error_saving")
    render :action => 'new'
  end

  def update
    @user.send(%{#{params[:state_event]}!}) unless params[:state_event].blank?
    @user.admin = params[:user][:admin]
    @user.update_attributes!(params[:user])
    redirect_to(admin_users_url)
    flash[:ok] = I18n.t("tog_user.admin.user_updated", :login => @user.login)
  rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_user.admin.error_saving")
    render :action => 'edit'
  end

  protected

  def find_user
    @user = User.find(params[:id]) if params[:id]
  end

  # Return a SQL order string from params (order_by and sort_order)
  # 
  # Check that order attribute exists in model or use default
  #
  def build_order(model, default_attribute, options = {})    
    order_by_field = options[:order_by_field] || :order_by
    sort_order_field = options[:sort_order_field] || :sort_order
    non_blank_or = lambda { |value, default| !value.blank? ? value: default }
    order_by = non_blank_or.call(params[order_by_field], default_attribute.to_s)
    sort_order = non_blank_or.call(params[sort_order_field], 'ASC')
    # Sanity checks
    order_by = default_attribute.to_s unless model.column_names.include?(order_by)
    sort_order = 'ASC' unless ['ASC', 'DESC'].include?(sort_order.upcase)
    [order_by, sort_order]
  end
end
