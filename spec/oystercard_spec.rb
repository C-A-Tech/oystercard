require 'oystercard'

describe Oystercard do
  # max_balance = Oystercard::MAX__BALANCE
  let(:max_balance)       { Oystercard::MAX__BALANCE }
  # entry_station = double("station")
  let(:entry_station)     { double :station }

  it 'is initialised with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#touch_in' do
    before {subject.top_up(max_balance)}

    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end    
    
    it  '#in_journey should be true after touch_in' do
      subject.touch_in(entry_station)    
      expect(subject).to be_in_journey
    end    
    
    it 'stores the entry station when touch in' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end      
    
    it 'refuses ride when less than minimum fare' do
      allow(subject).to receive(:balance).and_return 0
      expect {subject.touch_in("kingscross")}.to raise_error('insufficient balance')
    end
    
  end

  describe '#top_up' do
    before {subject.top_up(max_balance)}

    it 'it increases the balance of the card when the top_up method is given a value' do
      expect(subject.balance).to eq(max_balance)
    end

    it "raises an error when balance exceeds £90" do
      expect{subject.top_up(1)}.to raise_error("Balance cannot exceed £#{max_balance}")
    end

  end

  describe '#touch_out' do
    before {subject.top_up(max_balance)}
    before {subject.touch_in("kingscross")}

    it '#in_journey should be false after touch_out' do
      subject.touch_out("shoreditch")
      expect(subject).not_to be_in_journey
    end

    it 'deducts minimum fare from balance when journey is complete' do
      expect{subject.touch_out("shoreditch")}.to change{subject.balance}.by(-1)
    end

    it 'deletes the entry station at touch out' do
      subject.touch_out("shoreditch")
      expect(subject.entry_station).to eq(nil)
    end

    it 'stores the exit station when touch out' do
  
      subject.touch_out("shoreditch")
      expect(subject.exit_station).to eq("shoreditch")
    end

    it 'tests that journey history is an empty array by default' do
      expect(subject.journey_history).to eq []
    end

    it 'returns entire journey history when touch out' do
      subject.touch_out("shoreditch")
      expect(subject.journey_history).to eq([{"Entry Station"=>"kingscross", "Exit Station"=>"shoreditch"}])
    end

  end
  

end