class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def search?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def approve_booking
    user_is_owner_or_admin?
  end

  def reject_booking
    user_is_owner_or_admin?
  end

  def rent_booking
    user_is_owner_or_admin?
  end

  def finish_booking
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end
end

