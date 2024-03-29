class RegistrationsController < ApplicationController
    def new
        @customer = Customer.new 
    end

    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            session[:customer_id] = @customer.id
            redirect_to root_path, notice: "Successfully Created an Account"
        else
            flash[:alert] = "Something went wrong"
            render :new
        end
    end

    private
    
    def customer_params
        params.require(:customer).permit(:email, :password, :password_confirmation)
    end    
end