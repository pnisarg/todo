class TodoItemsController < ApplicationController

  before_action :set_todo_list
  before_action :set_todo_item, :except => [:create]

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
    if @todo_item.destroy
      flash[:notice] = "Todo List item was deleted."
    else
      flash[:notice] = "Todo List item could not be deleted."
    end
    redirect_to @todo_list
  end

  def complete
    @todo_item.update_attributes(:completed_at => Time.now)
    redirect_to @todo_list, :notice => "Todo item completed"
  end

  private
  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:content)
  end

end
