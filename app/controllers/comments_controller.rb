class CommentsController < ApplicationController
  # respond_to :js, :json, :html

  def index
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    @list = List.find(params[:list_id])
    @item = Item.find(params[:item_id])
    @listtags = @list.listTags
    @comment.item = @item
    @comment.user = current_user
    if @comment.save
        respond_to do |format|
          format.html { redirect_to list_path(@list) }
          format.js  # <-- will render `app/views/reviews/create.js.erb`
        end
      else
        respond_to do |format|
          format.html { render 'lists/show' }
          format.js  # <-- idem
        end
    end
    # redirect_to list_path(@list)
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :item_id, :user_id)
  end

end
