class Order < ActiveRecord::Base

  include ::EdgeStateMachine
  include ::ActiveRecord::EdgeStateMachine

  belongs_to :user
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items

  attr_protected :status
  #
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  #validates :email, presence: true, length: {maximum: 150}
  #
  #validates :phone_number, presence: true, length: {maximum: 15}
  #validates :phone_number2, length: {minimum: 0, maximum: 15}
  validates :delivery_address, presence: true, length: {maximum: 300, minimum: 2}
  validates :delivery_city, presence: true, length: {maximum: 250, minimum: 2}
  validates :delivery_zip_code, presence: true, length: {minimum: 5, maximum: 5}
  #validates :delivery_country, presence: true, length: {maximum: 150, minimum: 2}

  state_machine do
    create_scopes true
    persisted_to :status
    initial_state :ordering

    state :ordering
    state :ordered
    state :returned
    state :cancelled
    state :delivered

    event :order do
      transition to: :ordered, from: :ordering
    end

  end

  def self.status_map
    {
      :ordering => 'Nova',
      :ordered => 'Naruceno',
      :cancelled => 'Obustavljeno',
      :returned => 'Vraceno',
      :delivered => 'Isporuceno'
    }
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
      line_items.to_a.sum { |item| item.total_price }
  end


  def send_mail
    DeliveryMailer.delivery_notification(self).deliver
  end

end
