class PasswordsController < ApplicationController
    before_action :require_customer_logged_in!

    def edit

    end

    def update
        if Current.customer.update(password_params)
            redirect_to root_path, notice: "Password Updated!"
        else
            render :edit, status: :bad_request
        end
    end

    private

    def password_params
        params.require(:customer).permit(:password, :password_confirmation)
    end
end