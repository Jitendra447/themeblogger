class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check, only: [:edit]
  # layout :my_layout
  # GET /articles
  # GET /articles.json
  def index

    @masters=MasterCategory.all
    @blogs=BlogCategory.all

    # @articles =Article.all

    @search=Article.search do
    fulltext params[:search]
    paginate :page => 1, :per_page => 6
    end

    @search_author=Author.search do
    fulltext params[:search]
    paginate :page => 1, :per_page => 6
    end
    
    # @search_filter= Article.search do
      # fulltext params[:search]
      # with(:master_category_ids).all_of(params[:master_category_id]) unless params[:master_category_id].blank?     
   
    # end
    @search_filter= Article.search do |s| 
    s.with(:master_category_ids, params[:search]) 
    end
   # @search_filter= Article.search do
   #  fulltext params[:search]
   #  with(:master_category_ids).all_of(params[:master_category_id]) unless params[:master_category_id].blank?
   #  end

   

    # @ab =params[:ab]
     @articles= @search.results  
     @authors =@search_author.results

      @filters=@search_filter.results


#      respond_to do |format|
#       if @authors.present?
#          format.js   
#      end
# end

  end


  

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article_id = @article.id
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    # @author = Author.find(params[:author_id])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @author= Author.find(current_author.id)
    @article= Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
     
        # if params[:@abc].present?
        #     redirect_to articles_path(@articles)
        
        
        # else
        # respond_to do |format|
        #  format.js
        # end
        # end
  end

  def author_profile
       @author= Author.find(params[:id])    
  end


# def categories_properties
#     @article = Article.find(params[:article_id])
    
#     params[:category][:id].each do |category|
#       if !category.blank?
#         @placeCategory = Place_Category.new
#         @placeCategory.article_id = @article.id
#         @placeCategory.master_category_id = category
#         @placeCategory.save
#       end
#     end
#   end
# def my_layout
#   params[:action] == 'author_profile' ? 'application' : nil
# end

  def check
         @article = Article.find(params[:id])
      if current_author.id!=@article.author_id
         respond_to do |format|
         format.html { redirect_to articles_path, notice: 'You are not authorised.' }
         format.json { render :show, status: :ok, location: @article }
          end
     end
 end
 
def name
 
 if Author.where(:email => params[:email]).exists?
  @a=1
  end
 respond_to do |format|
  format.js
 
end
end

def autocomplete

  @title=Article.all
  @authorx=Author.all

   respond_to do |format|
    format.html
    format.json { render :json=>@title.to_json   }
    # format.json { render :json=>@authorx.to_json   }
end

end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :image, :author_id, :tag_list, :username, :name, :master_category_id)
    end
end
