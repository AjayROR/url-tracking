module StripInputs
extend ActiveSupport::Concern

  included do
    before_validation :strip_inputs
  end

  # Removes the empty spaces from the attributes.
  def strip_inputs
    attribute_names.each do |name|
      if send(name).respond_to?(:strip)
        send("#{name}=", send(name).strip)
      end
    end
  end

end