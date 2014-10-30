# https://www.interviewcake.com/question/product-of-other-numbers
# start = Time.now
class Product

  # Brute force way. O(n^2) time.
  def get_products_of_all_ints_except_at_index(array)
    answer = []
    array.length.times do |index|
      product = 1
      array.length.times do |index2|
        product *= array[index2] if index2 != index
      end
      answer << product
    end
    answer
  end

  # Better way. O(n) time.
  def get_products(array)
    answer = []

    product = 1
    array.length.times do |index|
      answer << product
      product *= array[index]
    end

    product = 1
    (array.length - 1).downto(0) do |index2|
      answer[index2] *= product
      product *= array[index2]
    end

    answer
  end

  # def multiply(array1, array2)
  #   array1.length.times.inject([]) do |product, i|
  #     product << array1[i] * array2[i]
  #   end
  # end
end

# answer before = [1,1,7,21]
# answer[3] = 21 * 1
# product = 4
# answer[2] = 7 * 4 = 28
# product = 4 * 3 = 12
# answer[1] = 1 * 12 = 12
# product = 4 * 3 * 7 = 84
# answer[0] = 1 * 4 * 3 * 7 = 84

# p = Product.new
# p p.get_products_of_all_ints_except_at_index([1, 7, 3, 4])
# puts "Time: #{Time.now - start} secs"
# start = Time.now
# p p.get_products([1, 7, 3, 4])

# puts "Time: #{Time.now - start} secs"