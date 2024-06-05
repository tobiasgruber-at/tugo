# This represents options for sorting a collection of items
# @!attribute [rw] target
#   @return [Symbol] the ordering target
# @!attribute [rw] direction
#   @return [Symbol] the ordering direction
class SortOption
  include ActiveModel::API
  include ActiveModel::Attributes

  # All possible targets
  TARGETS = [:title, :date]
  # All possible directions
  DIRECTIONS = [:desc, :asc]

  attribute :target, default: TARGETS[0]
  attribute :direction, default: DIRECTIONS[0]

  validates :target, allow_nil: true, allow_blank: false, inclusion: { in: TARGETS }
  validates :direction, allow_nil: true, allow_blank: false, inclusion: { in: DIRECTIONS }

  # Get the target
  #
  # @return [Symbol] the target
  def target
    attributes["target"].try(:to_sym)
  end

  # Get the direction
  #
  # @return [Symbol] the direction
  def direction
    attributes["direction"].try(:to_sym)
  end

  # Get the next target based on the current target.
  #
  # @return [Symbol] the next target
  def next_target
    next_value(target, TARGETS)
  end

  # Get the next direction based on the current direction.
  #
  # @return [Symbol] the next direction
  def next_direction
    next_value(direction, DIRECTIONS)
  end

  private

  # Get the next value based on the current value
  #
  # If the current value could not be found in the given collection,
  # the first value of the collection will be returned.
  #
  # @param [Symbol] current the current value
  # @param [Array<Symbol>] values all possible values for the current one
  # @return [Symbol]
  def next_value(current, values)
    index = values.index(current)
    next_index = index.nil? ? 0 : index + 1
    values[next_index % values.length]
  end
end
