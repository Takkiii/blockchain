=begin
  Block.new(
    hash: hash,
    height: height,
    transactions: transactions,
    timestamp: timestamp,
    nonce: nonce,
    previouts_hash: previouts_hash,
  )
=end

class Block
  attr_reader :hash, :height, :transactions, :timestamp, :nonce, :previouts_hash

  def initialize(args)
    @hash           = args[:hash]
    @height         = args[:height]
    @transactions   = args[:transactions]
    @timestamp      = args[:timestamp]
    @nonce          = args[:nonce]
    @previouts_hash = args[:previouts_hash]
  end

  def create_genesis_block
    # QUESTION: 適当なハッシュ値に変えた方が良い？
    adress = '62e907b15cbf27d5425399ebf6f0fb50ebb88f18'
    timestamp = Time.parse('2009/1/3').to_i
    previouts_hash = '0'
    genesis_coinbase_data = 'The Times 03/Jan/2009 Chancellor on brink of second bailout for banks'
    transactions = [Transaction.new_coinbase_transaction(adress, genesis_coinbase_data)]

    pow = ProofOfWork.new(
      timestamp: timestamp,
      previouts_hash: previouts_hash,
      transactions: transactions
    )
    nonce, hash = pow.do_proof_of_work
    Block.new(
      hash: hash,
      height: 0,
      transactions: transactions,
      timestamp: timestamp,
      nonce: nonce,
      previouts_hash: previouts_hash
    )
  end
end
