class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    if params[:section].blank?
       @book = Book.all.order("created_at DESC")
     else
      section_id=Section.find_by(name:params[:section]).id
      @book=Book.where(:section_id => section_id).order ("created_at DESC")
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.build
    @sections=Section.all.map {|s| [s.name, s.id]}
  end

  # GET /books/1/edit
  def edit
    @sections=Section.all.map { |s| [s.name, s.id]  } 
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
    @book.section_id=params[:section_id]

    respond_to do |format|
      if @book.save
        format.html { redirect_to root_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to root_path, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: root_path }
        @book.section_id=params[:section_id]
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_img, :title, :discription, :author,:section_id)
    end
end
