class ProductsController < ApplicationController
  before_action :set_product, only:[:edit, :show, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 8)
  end

  def new
    @product = Product.new    
  end

  def show;end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "Product was created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
    
  def edit;end

  def update
    @product = Product.find(params[:id])
     
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    #TODO Check if the product is associated with any order
    #May be we can add a validation in the model to check if the product is associated with any order
    @product.destroy

    redirect_to root_path, alert: "Deleted successfully."        
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :sku, :price, :stock_quantity)    
    end
end
