module ApplicationHelper
  def formatted_cep(cep)
    "#{cep[..4]}-#{cep[5..]}"
  end
end
