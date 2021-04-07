require 'oystercard'

describe Oystercard do
  
  it 'is initialised with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'it increases the balance of the card when the top_up method is given a value' do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it "raises an error when balance exceeds £90" do
    subject.top_up(90)
    expect{subject.top_up(1)}.to raise_error("Balance cannot exceed £#{Oystercard::MAX__BALANCE}")
  end

  it 'deducts £10 from balance' do
    subject.top_up(50)
    subject.deduct(10)
    expect(subject.balance).to eq(40)
  end

  it 'responds to touch_in' do
    expect(subject).to respond_to(:touch_in)
  end

  it  '#in_journey should be true after touch_in' do
    subject.touch_in    
    expect(subject).to be_in_journey
  end

  it '#in_journey should be false after touch_out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end