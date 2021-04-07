require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX__BALANCE }

  it 'is initialised with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#main' do
    before do
      subject.top_up(max_balance)
    end
   
    it 'it increases the balance of the card when the top_up method is given a value' do
      expect(subject.balance).to eq(max_balance)
    end

    it "raises an error when balance exceeds £90" do
      expect{subject.top_up(1)}.to raise_error("Balance cannot exceed £#{max_balance}")
    end

  # no longer need to have a test for deduct as our test for touch_out covers the logic in the deduct method 
    # it 'deducts £10 from balance' do
    #   subject.deduct(10)
    #   expect(subject.balance).to eq(40)
    # end

    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it  '#in_journey should be true after touch_in' do
      subject.touch_in("kingscross")    
      expect(subject).to be_in_journey
    end

    it '#in_journey should be false after touch_out' do
  
      subject.touch_in("kingscross")
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts minimum fare from balance when journey is complete' do
  
      subject.touch_in("kingscross")
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end

    it 'stores the entry station when touch in' do
  
      subject.touch_in("kingscross")
      expect(subject.entry_station).to eq("kingscross")
    end

    it 'deletes the entry station at touch out' do
      subject.touch_in("kingscross")
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end

  end
  
  it 'refuses ride when less than minimum fare' do
    expect {subject.touch_in("kingscross")}.to raise_error('insufficient balance')
  end

end