class User < ApplicationRecord
  def taunt_police0
    pp "taunt police"
  end

  enum status: {unassigned: 0, assigned: 1, resolved: 2, closed: 3} do
    event :assign do
      transition :unassigned => :assigned
    end

    event :resolve do
      before do
        pp "resolve"
      end

      transition [:unassigned, :assigned] => :resolved
    end

    event :close do
      after do
        pp "close"
        pp"検証"
      end

      transition all - [:closed] => :closed
    end

    def taunt_police
      pp "taunt"
    end

    def taunt_police2
      pp "taunt"
    end
  end

  def taunt_police
    pp "taunt police"
  end

  def taunt_police2
    pp "taunt police"
  end

  def taunt_police3
    pp "taunt police"
  end

  def taunt_police4
    pp "taunt police"
  end
end



