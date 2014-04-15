# InterviewCake: bracket validator
# https://www.interviewcake.com/question/bracket-validator

class Validator
  attr_reader :string
  def initialize(string)
    @string = string
  end

  def validates
    close_open = {'}' => '{', ']' => '[', ')' => '('}   # a hash that links right symbol to left symbol
    left_chars = close_open.values
    right_chars = close_open.keys
    top = [] # stack (data structure). shows current innermost left symbol---'{', '[', or '('
    string.length.times do |i|

      if left_chars.include?(string[i])
        top << string[i] # current innermost left symbol is now string[i]!
        puts "LEFT symbol"
        print "character = #{string[i]}, top: #{top}, index = #{i}\n"
      elsif right_chars.include?(string[i])
        puts "RIGHT symbol"
        print "character = #{string[i]}, top: #{top}, index = #{i}\n"

        # cannot have right-sided version without left-side version first. exit.
        if top == []
          puts "\nFALSE! We got right-side symbol without left-side first.\n\n"
          return false
        end

        if close_open[string[i]] == top.last  # our right symbol matches our innermost left symbol!
          top.pop # remove innermost left symbol from stack. we're done with it.
        else
          puts "\nFALSE! We got right-side symbol before closing innermost left side symbol.\n\n"
          return false  # we got wrong right symbol. it won't match. exit.
        end
      end

    end
    puts "\nTRUE!\n\n"
    true
  end
end