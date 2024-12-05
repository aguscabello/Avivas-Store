class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy edit_stock update_stock ]
  before_action :authenticate_user!, except: [ :index, :show ]


  # GET /products
  def index
    @q = Product.ransack(params[:q])
    if user_signed_in?
      @products = @q.result.with_deleted.includes(:rich_text_description)
    else
      @products = @q.result.includes(:rich_text_description)
    end
  end


  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # Edicion stock
  def edit_stock
  end

  def update_stock
    stock = product_params[:stock].to_i
    if stock > 0 && @product.update(product_params)
      redirect_to @product, notice: "Stock updated successfully."
    else
      flash.now[:alert] = "Stock must be greater than 0."
      render :edit_stock, status: :unprocessable_entity
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.update!(stock: 0)
    @product.update!(deleted_at: Time.current)
    redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.with_deleted.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :category_id, :color_id, :size, :created_at, :updated_at, :deleted_at, images: [])
    end
end
