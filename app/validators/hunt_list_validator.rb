class HuntListValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, values)
    return if values.blank?
    record.errors.add(attribute, "must not include hunts as leader (#{matching_values(record.hunts_as_leader, values)})") unless matching_values(record.hunts_as_leader, values).empty?
  end

  private

  def matching_values(ref, values)
    (ref & values)
  end

end
