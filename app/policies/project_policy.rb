class ProjectPolicy < ApplicationPolicy
  def create?
    return false if user.nil?
    true
  end
end