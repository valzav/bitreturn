class BitcoinWallet
  include Singleton
  attr_reader :wallet

  def initialize
    @wallet = RubyWallet.connect(:username => 'bitcoinrpc', :password => '3Fjwy6vH5wUnMVYcbZgGuWvbXWJi6mkjoodTjFnxXg9w')
  end

  def withdraw_all(account, to_address)
    res = {}
    amount = current_user.wallet_account.balance - 0.0005
    if amount < 0.0000001
      res[:error] = {message: 'Cannot withdraw: Insufficient funds'}
      return res
    end
    sr = account.send_amount(amount, to: to_address)
    if sr['error']
      #error example: {"result" => nil, "error" => {"code" => -3, "message" => "Invalid amount"}, "id" => "jsonrpc"}
      res[:error] = {code: res['error']['code'], message: res['error']['message']}
    else
      res[:amount] = amount
      res[:address] = to_address
      res[:txid] = sr
    end
    return res
  end

end
