class PasswordResetsController < ApplicationController
    def new

    end

    def create
        @customer = Customer.find_by(email: params[:email])

        if @customer.present?
            PasswordMailer.with(customer: @customer).reset.deliver_now
        end

        redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password"
    end

    def edit
        @customer = Customer.find_signed(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Your token has expired. Please try again."
    end

    def update
        @customer = Customer.find_signed(params[:token], purpose: "password_reset")
        if @customer.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
        else
            render :edit, status: :bad_request
        end

    end

private

    def password_params
        params.require(:customer).permit(:password, :password_confirmation)
    end
end