# http://www.codewars.com/kata/535bfa2ccdbf509be8000113/ruby
# Write your own Primes class with class method Primes.first(n) that
# returns an array of the first count prime numbers.

class Primes
  # Sieve of Eratosthenes, makes array of all primes from 2 to n
  def self.sieve(n)
    # make array of odd integers from 3 to n. Skip evens.
    s = 3.step(n, 2).to_a
    s.each do |p|
      next if p.nil?
      break if p * p > n   # p only needs to go up to sqrt(n)

      k, pval = 0, 0

      while pval < n
        # jump forward 2p at a time: p*p, p*p + 2p, p*p + 4p, etc.
        pval = p * (p + k)

        # Set all those multiples to nil. i = (pval - 3)/2 translates pvals to index i

        s[(pval - 3) / 2] = nil
        k += 2
      end

    end
    s.compact!    # removes all nil elements from array
    s.unshift(2).sort  # adds 2 as 1st element
  end

  # array of the first count primes
  def self.first(count)
    #n = 650_000  # Try all primes up to n
  # http://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number
  # The nth prime is approx n ln(n).
    n = count * Math.log(count)
    sieve(n)[0..count - 1]
  end
end

# Test cases:

# Test.assert_equals(Primes.first(1), [2])
# Test.assert_equals(Primes.first(2), [2, 3])
# Test.assert_equals(Primes.first(5), [2, 3, 5, 7, 11])
# Test.assert_equals(Primes.first(20).last(5), [53, 59, 61, 67, 71])
# Test.assert_equals(Primes.first(100)[99], 541)
# Test.assert_equals(Primes.first(1000)[999], 7919)
# Test.assert_equals(Primes.first(50000)[49999], 611953)
# Test.expect(Primes.first(50001).last == 611957)
# Test.expect(Primes.first(50002).last == 611969)
# Test.expect(Primes.first(50003).last == 611977)
# Test.expect(Primes.first(50004).last == 611993)
# Test.expect(Primes.first(50005).last == 611999)
# Test.expect(Primes.first(50005)[10000] == 104743)
# Test.expect(Primes.first(50005)[40001] == 479951)
# Test.expect(Primes.first(30007).last(5) == [350423, 350429, 350431, 350437, 350443])
# Test.expect(Primes.first(20004).last(5) == [224737, 224743, 224759, 224771, 224797])
# Test.expect(Primes.first(49999)[49995...-1] == [611921, 611927, 611939])
