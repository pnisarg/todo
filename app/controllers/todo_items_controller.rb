class TodoItemsController < ApplicationController

  before_action :set_todo_list

  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.todo_list = @todo_list
    if @todo_item.save
      flash[:notice] = "Todo Item created successfully."
      redirect_to @todo_list
      # redirect_to(:action => "index")
    else
      render("new")
    end
  end

  def destroy
    # @todo_item = TodoItem.find(params[:id])
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted."
    else
      flash[:error] = "Todo List item could not be deleted."
    end
    redirect_to @todo_list
  end

  private
  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:content)
  end

end
