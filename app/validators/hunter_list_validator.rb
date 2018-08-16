class HunterListValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, values)
    return if values.blank?
    record.errors.add(attribute, "can't include the leader (#{record.leader.username})") if values.include?(record.leader)
  end

end
