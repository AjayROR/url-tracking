module ApplicationHelper

  def base_error(url)
    url.errors.messages.first[1][0] if url.errors.present?
  end

  def flash_class(name)
    name.to_s
  end

end
