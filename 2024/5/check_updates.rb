class CheckUpdates
  class Rules
    attr_reader(:first, :second)
    def initialize(first, second)
      @first = first
      @second = second
    end
    
    def valid?(update)
      first_index = update.index(@first) 
      second_index = update.index(@second)

      !first_index || !second_index || first_index < second_index
    end

    def fix(update)
      first_index = update.index(@first) 
      second_index = update.index(@second)

      update[first_index] = @second
      update[second_index] = @first

      update
    end
  end

  def initialize(ruleset, updates)
    @ruleset = ruleset
    @updates = updates

    @correctly_ordered = []
    @incorrectly_ordered = []
  end

  def run
    @correctly_ordered = @updates.select { |update| ordered?(update) }
    @incorrectly_ordered = @updates - @correctly_ordered

    @correctly_ordered
  end

  def middle_page_number
    @correctly_ordered.map {|update| update[update.length / 2] }.sum
  end

  def middle_page_number_incorrect
    @incorrectly_ordered.map {|update| update[update.length / 2] }.sum
  end

  def ordered?(update)
    @ruleset.all? { |rule| rule.valid?(update) }
  end

  def fix_incorrect_order
    incorrects = @incorrectly_ordered.dup
    incorrects.map do |incorrect_update|
      @ruleset.each do |rule|
        next if rule.valid?(incorrect_update)

        f = rule.fix(incorrect_update)
        f
      end
    end


    incorrects.map do |incorrect_update|
      @ruleset.each do |rule|
        next if rule.valid?(incorrect_update)

        f = rule.fix(incorrect_update)
        f
      end
    end

    incorrects.map do |incorrect_update|
      @ruleset.each do |rule|
        next if rule.valid?(incorrect_update)

        f = rule.fix(incorrect_update)
        f
      end
    end

    incorrects
  end
end
