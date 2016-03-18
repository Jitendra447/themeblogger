class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check, only: [:edit]

  # GET /comments
  # GET /comments.json
  # def index
  #   @comments = Comment.all
  # end

  # GET /comments/1
  # GET /comments/1.json
  # def show
  # end

  # GET /comments/new
  # def new
  #   @comment = Comment.new
  #   @article= Article.find(params[:article_id])
  # end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
    # @comment.article_id = params[:article_id]
    respond_to do |format|
    format.js {render :layout => false} 
    end

    # respond_to do |format|
    # format.html { redirect_to article_comment_path(:article_id => @comment.article.id, :id => @comment.id) }
  end
 # format.js
#        
#       if params[:@xyz].present?

#         respond_to do |format|
#         format.js {render :layout => false} 
#       end
# else
#         respond_to do |format|
#         # format.html { redirect_to article_comment_path(:article_id => @comment.article.id, :id => @comment.id) }
#         # format.js
#         end


#         end




  # POST /comments
  # POST /comments.json
  def create

    @comment = Comment.new(comment_params)
    @article= Article.find(params[:article_id])
    @comment.article_id = params[:article_id]
   
    @comm=Comment.where(:article_id => params[:article_id])
   @c = @comm.count
    respond_to do |format|
      if @comment.save
       format.js
     end
   end
    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to article_path(@article.id), notice: 'Comment was successfully created.' }
    #     format.json { render :show, status: :created, location: @article }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
  end

     # redirect_to article_path(@comment.article_id)
       # respond_to do |format|
       #  if @comment.save
       #        format.js
       #          end
       #    end 



  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

     @comment = Comment.find(params[:id])
     @article= Article.find(params[:article_id])
      # @comment.article_id = params[:article_id]

      @comment.update(comment_params)
      respond_to do |format|

           format.js
      #   format.html { redirect_to article_path(@comment.article.id), notice: 'Comment was successfully updated.' }
      #   format.json { render :show, status: :ok, location: @article }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @article.errors, status: :unprocessable_entity }
    
    end

  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
   @author= Author.find(current_author.id)
   @comment = Comment.find(params[:id])
   @article = Article.find(params[:article_id])
   @comment_id = @comment.id
   if @comment.destroy
    respond_to do|format|
      format.js
    end


    # respond_to do |format|
    #   format.html { redirect_to article_path(@comment.article_id), notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }


  end
end

def check
  @comment = Comment.find(params[:id])
  if current_author.id!=@comment.author_id
   respond_to do |format|
     format.html { redirect_to articles_path, notice: 'You are not authorised.' }
     format.json { render :show, status: :ok, location: @comment }
   end
 end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :author_id, :article_id)
    end
  end
