class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show edit update destroy ]
  before_action :authenticate_user!


  # GET /sales
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.sold_products.build
  end



  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    ActiveRecord::Base.transaction do
      @sale.save!

      product_quantities = params[:sale][:product_quantities] || {}
      product_quantities.each do |product_id, quantity|
        next if quantity.to_i <= 0

        sold_product = SoldProduct.create!(
          sale: @sale,
          product_id: product_id,
          quantity: quantity,
          price: Product.find(product_id).price
        )

        product = sold_product.product
        product.update!(stock: product.stock - sold_product.quantity)
      end
      @sale.calculate_total
      @sale.save!
    end

     redirect_to @sale, notice: "Sale was successfully created."

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Error: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: "Sale was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy!
    redirect_to sales_path, notice: "Sale was successfully canceled.", status: :see_other
  end

  private
    def set_sale
      @sale = Sale.find(params.expect(:id))
    end

    def sale_params
      params.require(:sale).permit(:user_id, :date, :total, :canceled, :client_name, sold_products_attributes: [ :product_id, :quantity, :price ])
    end
end
