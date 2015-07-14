class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    #instantiate a new object using form parameters
    #@article = Article.new(params[:article])  
     @article = Article.new(article_params)
    #save the object
    if @article.save
    #if save succeeds, redirect to index
      redirect_to(:action =>'index')
      flash.notice = "Article '#{@article.title}' has been created"
    else
    #if save fails, redisplay the form
      render('new')  
    end 
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    #Similar to Article.new where you can pass in the hash of form data. 
    #It changes the values in the object to match the values submitted with the form.
    #Unlike Article.new, update automatically saves the changes
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to article_path(@article)
    flash.notice = "Article '#{@article.title}' has been updated"
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to action: "index"    
    flash.notice = "Article '#{@article.title}' has been deleted"
  end

  private
    def article_params
      # same as using "params[:article]", except that it:
      # -raises error if :article is not present;
      # -allows listed attributes to be mass assigned
      params.require(:article).permit(:title, :body)
    end

end
