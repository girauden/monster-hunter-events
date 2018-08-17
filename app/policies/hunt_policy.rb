class HuntPolicy < ApplicationPolicy

  def join?
    hunt.hunters.exclude?(user) && (user != hunt.leader) && ((hunt.hunters.size + 1) < hunt.max_hunter)
  end

  def create?
    user.present?
  end

  def sid_update?
    user.present? && (user == hunt.leader)
  end

  def leave?
    user.present? && hunt.hunters.include?(user)
  end

  def destroy?
    user.present? && (user == hunt.leader)
  end

  private

  def hunt
    record
  end
end
