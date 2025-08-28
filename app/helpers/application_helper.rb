module ApplicationHelper
  def display_name_for(record)
    %i[name subject summary cause description notes title].each do |attr|
      return record.public_send(attr) if record.respond_to?(attr) && record.public_send(attr).present?
    end

    # Default
    "#{record.model_name.human} ##{record.id}"
  end
end
