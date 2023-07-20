class TweetsController < ApplicationController
    before_action :require_customer_logged_in!
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]

    def index
        @tweets = Current.customer.tweets
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.customer.tweets.create(tweet_params)   
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet was published successfully"
        else
            flash[:alert] = "Something went wrong"
            render :new
        end
    end

    def edit
    end

    def update
        if @tweet.update(tweet_params)
            redirect_to tweets_path, notice: "Tweet was updated successfully"
        else
            render :edit
        end
    end 

    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet has been deleted"
    end

    private

    def tweet_params
        params.require(:tweet).permit(:body)
    end

    def set_tweet
        @tweet = Current.customer.tweets.find(params[:id])
    end
end