class HunterListValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, values)
    return if values.blank?
    p 'coucou' if (record.hunters.size + 1) >= record.max_hunter
    record.errors.add(attribute, "can't include the leader (#{record.leader.username})") if values.include?(record.leader)
    record.errors.add(attribute, "can't join a full hunt (#{record.hunters.size + 1 }/#{record.max_hunter} hunters)") if (record.hunters.size + 1) >= record.max_hunter
  end

end
