module Roll
  extend ActiveSupport::Concern

  def roll_2d6 
    2 + rand(6) + rand(6)
  end

  def roll_stats
    [ roll_2d6, roll_2d6, roll_2d6, roll_2d6, roll_2d6, roll_2d6 ]
  end

  def store_stats
    session[:stat_array] = roll_stats
  end
end
