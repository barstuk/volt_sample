module Main

  class TodoController < Volt::ModelController

    def add_todo
      model.save! do
        flash._successes.clear
        flash._successes << "Succesfully created todo"
        self.model = store._todos.buffer
      end.fail do |errors|
        return if Volt.logger.debug(model.marked_errors["name"])
        flash._errors.clear
        flash._errors << errors.to_s
      end
    end

    def remove_todo(todo)
      if store._todos.delete(todo)
        flash._successes.clear
        flash._successes << "Succesfully deleted todo"
      else
        flash._errors.clear
        flash._errors << "Unable to save because you're not on the internet"
      end
    end

    def bulk_destroy_todo
      store._todos.select {|t| t }.each(&:destroy)
    end

    def current_todo
      _todos[params._index.to_i]
    end

    def todos
      self.model = store._todos.buffer
    end

  end
end
