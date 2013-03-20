class OrdersController < ApplicationController
  
  before_filter :logged_in

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @items = @order.line_items
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    #raise current_cart.to_yaml
    logger.info('gate 1')
    respond_to do |format|
      if @order.save
        @order.order!
        @order.send_mail
        logger.info('gate 2')
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to orders_path, notice: 'Thank you for your order.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        logger.error(@order.errors)
        @cart = current_cart
        format.html { render action: "new", notice: @order.errors }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def current_ability
    @current_ability ||= CustomerAbility.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, :flash => { :error => 'Morate biti ulogovani da bi obavili narucivanje proizvoda.' }
  end

  private
  def logged_in
    store_location
    authenticate_user!
  end

end

