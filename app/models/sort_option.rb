class SortOption
  include ActiveModel::API
  include ActiveModel::Attributes

  TARGETS = [:title, :date]
  DIRECTIONS = [:desc, :asc]

  attribute :target, default: TARGETS[0]
  attribute :direction, default: DIRECTIONS[0]

  validates :target, allow_nil: true, allow_blank: false, inclusion: { in: TARGETS }
  validates :direction, allow_nil: true, allow_blank: false, inclusion: { in: DIRECTIONS }

  # force symbol return type
  def target
    attributes["target"].try(:to_sym)
  end

  # force symbol return type
  def direction
    attributes["direction"].try(:to_sym)
  end

  def next_target
    next_value(target, TARGETS)
  end

  def next_direction
    next_value(direction, DIRECTIONS)
  end

  private

  def next_value(current, values)
    index = values.index(current)
    next_index = index.nil? ? 0 : index + 1
    values[next_index % values.length]
  end
end
