module V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /todos
    def index
      # get paginated current user todos
      @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
      json_response(@todos)
    end

    # POST /todos
    def create
      @todo = current_user.todos.create!(todo_params)
      json_response(@todo, :created)
    end

    # GET /todos/:id
    def show
      json_response(@todo)
    end

    # PUT /todos/:id
    def update
      @todo.update(todo_params)
      head :no_content
    end

    # DELETE /todos/:id
    def destroy
      @todo.destroy
      head :no_content
    end

    private

    # remove `created_by` from list of permitted parameters
    def todo_params
      # whitelist params
      params.permit(:title)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
  end
end