class ListingPolicy < ApplicationPolicy
  before_action :find_listing, only: [:show, :edit, :update, :destroy]

  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def create?
    true #anyone can create a restaurant
  end

  def update?
  end

  def destroy?
  end

  private

  def user_is_owner_or_admin?
    record.user == user || user.admin
  end
end
