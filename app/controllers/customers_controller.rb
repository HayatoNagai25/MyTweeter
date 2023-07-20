class CustomersController < ApplicationController
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
  end