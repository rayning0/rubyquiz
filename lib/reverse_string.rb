# reverse a string
class Reverse
  def reverse(string)
    # (0..string.length / 2 - 1).each do |i|
    #   string[i], string[-i - 1] = string[-i - 1], string[i]
    # end

    # recursive way
    if string.size <= 1
      string
    else
      "#{string[-1]}#{reverse(string[0..-2])}"
    end
  end
end