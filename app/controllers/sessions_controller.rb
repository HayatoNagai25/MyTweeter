class SessionsController < ApplicationController
    def new
    end

    def create
        customer = Customer.find_by(email: params[:email])
        if customer.present? && customer.authenticate(params[:password])
            session[:customer_id] = customer.id
            redirect_to root_path, notice: "Logged in successfully"
        else
            flash[:alert] = "Invalid email or password"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out"
    end
end