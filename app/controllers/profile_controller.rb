class ProfileController < ApplicationController
    before_action :require_customer_logged_in!
  
    def create
      @customer = Customer.find(params[:relationship][:followed_id])
      current_customer.follow!(@customer)
      respond_to do |format|
        format.html { redirect_to @customer }
        format.js
      end
    end
  
    def destroy
      @customer = Relationship.find(params[:id]).followed
      current_customer.unfollow!(@customer)
      respond_to do |format|
        format.html { redirect_to @customer }
        format.js
      end
    end
  end