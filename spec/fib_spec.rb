require 'spec_helper'
require 'fib'

describe Fibonacci do
  let(:f) { Fibonacci.new }

  it "#fib" do
    # expect(f.fib(0)).to eq(1)
    expect(f.fib(1)).to eq(1)
    expect(f.fib(2)).to eq(1)
    expect(f.fib(3)).to eq(2)
    expect(f.fib(4)).to eq(3)
    expect(f.fib(5)).to eq(5)
    expect(f.fib(6)).to eq(8)
    expect(f.fib(7)).to eq(13)
    expect(f.fib(2000)).to eq(4224696333392304878706725602341482782579852840250681098010280137314308584370130707224123599639141511088446087538909603607640194711643596029271983312598737326253555802606991585915229492453904998722256795316982874482472992263901833716778060607011615497886719879858311468870876264597369086722884023654422295243347964480139515349562972087652656069529806499841977448720155612802665404554171717881930324025204312082516817125)
  end
end