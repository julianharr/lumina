class Friendable < ApplicationRecord
  def on_friendship_created(friendship)
  end

  def on_friendship_accepted(friendship)
  end

  def on_friendship_blocked(friendship)
  end

  def on_friendship_destroyed(friendship)
  end
end
