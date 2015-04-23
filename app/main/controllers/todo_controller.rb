module Main

  class TodoController < Volt::ModelController

    def add_todo
      model.save! do
        params._index = `$('.todo-table tr').size() - 1`
        flash._successes.clear
        flash._successes << "Succesfully created todo"
        self.model = store._todos.buffer
      end.fail do |errors|
        return if model.marked_errors["name"]
        flash._errors.clear
        flash._errors << errors.to_s
      end
    end

    def add_description
      current_todo.save!
    end

    def remove_todo(todo, index)
      if store._todos.delete(todo)
        params._index = index
        flash._successes.clear
        flash._successes << "Succesfully deleted todo"
      else
        flash._errors.clear
        flash._errors << "Unable to save because you're not on the internet"
      end
    end

    def todos
      self.model = store._todos.buffer
    end

    def current_todo
      store._todos[params._index.to_i]
    end
  end
end
