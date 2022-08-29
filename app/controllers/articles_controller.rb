class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all.order(updated_at:"DESC")
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if is_author?(@article)
      puts "#"*100
      puts "Oui c est l'auteur"
      puts "#"*100

      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      puts "#"*100
      puts "Non c'est pas l'auteur"
      puts "#"*100
      flash.alert = "Only author is allowed." # Ne s'affiche pas
      redirect_to root_path
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    # if @article.user === current_user

    if is_author?(@article)
      @article.destroy

      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      flash.alert = "Only author is allowed."
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private)
    end

    def is_author?(article)
      article.user === current_user ? true : false
    end
end
