# http://www.codewars.com/kata/5202ef17a402dd033c000009

class TitleCase
  def title_case(title, minor_words = '')
    title.capitalize.split().map{|a| minor_words.downcase.split().include?(a) ? a : a.capitalize}.join(' ')
  end
end