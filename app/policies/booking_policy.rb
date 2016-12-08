class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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

  def cancel_booking?
    user_is_owner_or_admin?
  end

  def list_users?
    user_is_owner_or_admin?
  end

  def approve_booking?
    user_is_offering?
  end

  def reject_booking?
    user_is_offering?
  end


  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end

  def user_is_offering?
    record.listing.user == user || user.admin
  end
end
