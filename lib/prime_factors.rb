# http://www.codewars.com/kata/534a0c100d03ad9772000539/train/ruby
# returns a hash where the keys are prime numbers
# and the values are their multiplicities.

# PrimeFactorizer.new(24).factor should return { 2 => 3, 3 => 1 }
class PrimeFactorizer
  attr_reader :n, :factor_hash, :factors
  def initialize(n)
    @n = n
    @factor_hash = {}
    @factors = []
  end
  def factor
    f = 2

    while f * f <= n    # only must check up to sqrt(n)
      if n % f == 0
        check_multiplicity(f)
        @factors << f
        # key line! After you find a factor, only check quotient afterwards
        @n = n / f
      else
        f += 1
      end
    end

    check_multiplicity(n)
    @factors << n
    factor_hash
  end

  def check_multiplicity(f)
    !factors.include?(f) ? @factor_hash[f] = 1 : @factor_hash[f] += 1
  end
end