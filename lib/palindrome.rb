class Palindrome
  def find_pal(str)
    s = str.split(',')
    longest_pal = []

    s.each_with_index do |num_start, index|
      arr = [num_start]

      s[index + 1..-1].each do |num_end|

  # Don't do arr << num_end, because this
  # does NOT change memory address of arr!
  # arr = arr + [num_end] really means:
  # arr (NEW MEMORY ADDRESS) = arr (OLD MEMORY ADDRESS) + [num_end]
        arr = arr + [num_end]
        p arr
        if is_palindrome?(arr) && arr.length > longest_pal.length
          puts "arr = #{arr}, longest_pal=#{longest_pal}"

          # points longest_pal to NEW MEMORY ADDRESS of arr,
          # keeping longest_pal from changing when
          # arr (OLD MEMORY ADDRESS) does!
          longest_pal = arr
        end
      end

      puts "longest_pal= #{longest_pal}"
    end

    longest_pal.join(',')
  end

  def is_palindrome?(arr)
    arr == arr.reverse
  end
end