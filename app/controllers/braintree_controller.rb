class BraintreeController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
    @order_item = current_order.order_items.new
    @order_items = current_order.order_items
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => current_order.subtotal, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      flash[:success] = "Payment successful. Thank you for shopping at ShopiBuy"
      current_order.order_items.destroy_all
      redirect_to root_path
    else
      flash[:error] = "Transaction failed. Please try again."
      redirect_to root_path
    end
  end

end
