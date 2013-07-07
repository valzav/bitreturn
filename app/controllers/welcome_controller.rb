class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
  end

  def test_widget
  end

  def generate_address
    user = User.find_by_api_key(params[:api_key])
    addr = Address.create(user: user, page_url: params[:page_url], page_title: params[:page_title])
    render json: { address: addr.bitcoin_address }, callback: params[:callback]
  end

  def widget_data
    amount = view_context.mf IncomingTransaction.get_page_amount(params[:page_url])
    #amount = view_context.mf Money.new(123456)
    res = %{<div id="btmw_data" class="btmw-data-box" style="width:#{amount.length.to_f/2.0+0.5}em;">#{amount}</div>}
    render json: { data: res }, callback: params[:callback]
  end


end
