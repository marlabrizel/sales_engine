class Customer
  attr_reader :created_at,
              :last_name,
              :updated_at,
              :id,
              :first_name,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def invoices
    @invoices ||= @repository.find_invoices(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    successful_transactions = transactions.select { |t| t.result == "success" }

    successful_invoices = successful_transactions.map { |st| st.invoice}

    # successful_merchants = successful_invoices.map { |si| si.merchant}
    successful_merchants = successful_invoices.map(&:merchant).compact
    binding.pry
    grouped_merchants = successful_merchants.group_by { |merchant| merchant.id }.values
    # binding.pry
    grouped_merchants.max_by(&:count).first
  end
end
