module ApplicationHelper

  def text_snippet(text, length)
    if text.length > length
      "#{text[0..length]}..."
    else
      text
    end
  end

end
