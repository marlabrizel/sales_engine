class InvoiceItemRepository

  attr_reader :invoice_items,
              :sales_engine

  def initialize(data, sales_engine)
    @invoice_items = data.map { |attributes| InvoiceItem.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@invoice_items.size} rows"
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_by_item_id(item_id)
    invoice_items.find do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_by_quantity(quantity)
    invoice_items.find do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def find_by_unit_price(unit_price)
    invoice_items.find do |invoice_item|
      invoice_item.unit_price == unit_price
    end
  end

  def find_by_created_at(created_at)
    invoice_items.find do |invoice_item|
      invoice_item.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    invoice_items.find do |invoice_item|
      invoice_item.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    invoice_items.find_all do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.find_all do |invoice_item|
      invoice_item.unit_price == unit_price
    end
  end

  def find_all_by_created_at(created_at)
    invoice_items.find_all do |invoice_item|
      invoice_item.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.find_all do |invoice_item|
      invoice_item.updated_at == updated_at
    end
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_invoice_item_id(id)
  end

  def find_item(item_id)
    sales_engine.find_item_by_item_id(item_id)
  end

  def create_invoice_items(items, new_invoice_id)
    items.map do |item|
      new_invoice_item = InvoiceItem.new({id: next_id,
                       item_id: item.id,
                       invoice_id: new_invoice_id,
                       quantity: 1,
                       unit_price: item.unit_price,
                       created_at: Time.new.strftime("%c %d, %Y"),
                       updated_at: Time.new.strftime("%c %d, %Y")
                      },
                      self
                      )
      invoice_items << new_invoice_item
    end
  end

  private

  def next_id
    if invoice_items.last.nil?
      1
    else
      invoice_items.last.id.next
    end
  end
end
