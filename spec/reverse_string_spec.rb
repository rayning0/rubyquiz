require 'spec_helper'
require 'reverse_string'

describe Reverse do
  let(:s) { Reverse.new }
  it 'should reverse a string' do
    expect(s.reverse("Even")).to eq("nevE")
    expect(s.reverse("Odd")).to eq("ddO")
    expect(s.reverse("Madam, I'm Adam")).to eq("madA m'I ,madaM")
    expect(s.reverse("It's wonderful if they know other languages, and in fact those who do tend to do a lot better overall. But to be an Amazon SDE, you need to prove you can do C++ or Java first.")).to eq(".tsrif avaJ ro ++C od nac uoy evorp ot deen uoy ,EDS nozamA na eb ot tuB .llarevo retteb tol a od ot dnet od ohw esoht tcaf ni dna ,segaugnal rehto wonk yeht fi lufrednow s'tI")
    expect(s.reverse("It's wonderful if they know other languages, and in fact those who do tend to do a lot better overall. But to be an Amazon SDE, you need to prove you can do C++ or Java first")).to eq("tsrif avaJ ro ++C od nac uoy evorp ot deen uoy ,EDS nozamA na eb ot tuB .llarevo retteb tol a od ot dnet od ohw esoht tcaf ni dna ,segaugnal rehto wonk yeht fi lufrednow s'tI")
  end
end