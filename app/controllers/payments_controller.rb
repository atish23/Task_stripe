class PaymentsController < ApplicationController
    before_filter :authenticate_user!
    def index
      @users = User.all
      @users.each do |user|
        charges = Stripe::Charge.retrieve(customer: user.stripe_id)
        raise charges.inspect
      end
    end
    def new
        
    end
    
    def create
       @amount = 1000
       
      # customer = Stripe::Customer.create(
      #       :email => params[:stripeEmail],
      #       :source => params[:stripeToken] 
      #     )
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.sources.create(source: params[:stripeToken])
        Stripe::Charge.create(
            :customer =>  customer.id,
            :amount   =>  @amount,
            :description  => "Charges By User",
            :currency => 'usd'
           )
        rescue Stripe::CardError  => e
          flash[:error] = e.message
          redirect_to root_path
    end
end
