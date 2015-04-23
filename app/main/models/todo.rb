class Todo < Volt::Model

  validate :name, presence: true, length: 5, unique: true

  def percent_complete(store)
    ((complete_todos(store).size / store._todos.size.to_f) * 100.0).round
  end

  def complete_todos(store)
    store._todos.select {|t| t._completed == true }
  end

  def bulk_incomplete_todos(store)
    complete_todos(store).each { |t| t._completed = false}
  end

  def incomplete_todos_size(store)
    incomplete_todos(store).size
  end

  def incomplete_todos(store)
    store._todos.select {|t| !t._completed }
  end

  def bulk_destroy_todos(store)
    store._todos.select {|t| t }.each(&:destroy)
  end

  def bulk_complete_todos(store)
    incomplete_todos(store).each { |t| t._completed = true}
  end

  def bulk_destroy_completed_todos(store)
    complete_todos(store).each(&:destroy)
  end

end
