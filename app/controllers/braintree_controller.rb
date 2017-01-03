class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    @reservation = Reservation.find(params[:braintree][:reservation_id])
    result = Braintree::Transaction.sale(
      :amount => "#{@reservation.get_total_price}",
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
        }
      )
    if result.success?
      redirect_to :root, :flash => {:success => "Transaction successful!"}
    else
      message = "Transaction failed. Please try again."
      redirect_to :root, :flash => {:error => message}
    end
  end
    # end of class
end
