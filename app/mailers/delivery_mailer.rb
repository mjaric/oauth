class DeliveryMailer

  default :from => 'toni.petrovic@gmail.com',
          :bcc => (Rails.env.production? ? %w(toni.petrovic@gmail.com) : %w(toni.petrovic@gmail.com))


  def delivery_notification(order)
    @order = order
    headers['Reply-to'] = 'toni.petrovic@gmail.com'

    mail(:to => @order.email,
         :content_type => 'text/html',
         :recipients => (Rails.env.production? ? @order.email : 'toni.petrovic@gmail.com'),
         :subject => "#{'[OVO JE TEST]' if Rails.env.development?} Zahtev za dostavu ##{@order.id}")
  end

end