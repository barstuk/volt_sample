class Todo < Volt::Model
  validate :name, presence: true, length: 5
end