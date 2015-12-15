class Palindrome
  def find_pal(str)
    s = str.split(',')

    # iterate thru array
    # [1, 7] =? [7, 1] NO
    # [1, 7, 3] =? [3, 7, 1] NO
    # [1, 7...2] =? [2...1] NO
    # [7, 3] =? [3, 7] NO
    longest_pal = []

    s.each_with_index do |num_start, index|
      arr = [num_start]

      s[index + 1..-1].each do |num_end|

        # make COPY of arr with "dup" (different memory address)
        array_copy = arr.dup << num_end

        arr << num_end
        p arr
        if is_palindrome?(arr) && arr.length > longest_pal.length
          puts "arr = #{arr}, longest_pal=#{longest_pal}"

    # Don't put longest_pal = arr, because then longest_pal
    # points to MEMORY ADDRESS of arr. As arr increases size,
    # longest_pal will too. In other words, saying "a = b" in Ruby
    # means "Point a to home address of b. No matter what b actually
    # equals, a will equal the same."

    # Setting longest_pal = a COPY of arr means longest_pal will
    # NOT automatically change when arr changes!
          longest_pal = array_copy
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