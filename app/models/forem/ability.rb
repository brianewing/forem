require 'cancan'

module Forem
  class Ability < ::Ability

    def initialize(user)
      # Let other permissions run before this
      super

      user ||= User.new # anonymous user

      can :read, Forem::Category do |category|
        user.can_read_forem_category?(category)
      end

      if user.can_read_forem_forums?
        can :read, Forem::Forum do |forum|
          user.can_read_forem_forum?(forum)
        end
      end
    end
  end
end