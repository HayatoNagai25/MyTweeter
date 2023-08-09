class CustomersController < ApplicationController
  before_action :signed_in_customer, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_customer, only: [:edit, :update]

  def index
    @customers = Customer.paginate(page: params[:page])
  end

  def show
    @cusotmer = Customer.find(params[:id])
  end

  def new
    @customer - Customer.new
  end

  def create
    @customer = Customer.new(custromer_params)
    if @customer.save
      sign_in @customer
      flash[:success] = "Welcome to My Tweeter!"
      redirect_to @customer
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      flash[:success] = "Profile Updated"
      redirect_to @customer
    else 
      render 'edit'
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = "Customer Destroyed."
    redirect_to customers_url
  end

  def following
    @title = "Following"
    @customer = Customer.find(params[:id])
    @cusotmers = @customer.followed_customers.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @customer = Cusotmer.find(params[:id])
    @customers = @customer.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def follow
    @customer = Customer.find(params[:id])
    @current_customer.followees << @customer
    redirect_to customer_path(@customer)
  end

  def unfollow
    @customer = Customer.find(params[:id])
    @current_customer.followed_customer.find_by(followee_id: @customer.id).destroy
    redirect_to customer_path(@customer)
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_customer
      @customer = Customer.find(params[:id])
      redirect_to(root_url) unless current_customer?(@customer)
    end
end