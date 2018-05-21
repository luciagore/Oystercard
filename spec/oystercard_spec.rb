require 'Oystercard' 

describe Oystercard do

	describe 'responds to methods' do
		it 'responds to the method balance' do
			expect(subject).to respond_to(:balance)
		end
		it 'responds to the topup balance' do
			expect(subject).to respond_to(:topup).with(1).argument
		end
		it 'responds to the topup balance' do
			expect(subject).to respond_to(:deduct).with(1).argument
		end
		it 'responds to touching in' do
			expect(subject).to respond_to(:touch_in)
		end
		it 'responds to being on journey' do
			expect(subject).to respond_to(:in_journey?)
		end
		it 'responds to being touched out' do
			expect(subject).to respond_to(:touch_out)
		end
	end

	describe '#balance' do 
		it 'contains default balance of 0' do
			expect(subject.balance).to eq 0
		end
	end

	describe '#topup' do 
		it 'tops up balance' do
			value = 22
			expect{ subject.topup(value) }.to change{ subject.balance }.by(value)
		end

		it 'raises error when maximum balance is reached' do
			b = Oystercard.new
			b.topup(90)
			expect { b.topup(1) }.to raise_error "Cannot top up: maximum balance of £#{ Oystercard::MAXIMUM_BALANCE } reached"
		end
	end

	describe '#deduct' do
		it 'deducts balance for fare' do 
			value = 22
			expect{ subject.deduct(value) }.to change{ subject.balance }.by(-value)

		end
	end

	describe '#touch_in' do
		it 'records the start of journey' do
			subject.touch_in
			expect(subject.status).to eq "Touched in"
		end
	end

	describe '#in_journey' do
		it 'records the journey' do
			subject.touch_in
			expect(subject.in_journey?).to eq true
		end
	end

	describe '#touch_out' do
		it 'records the end of the journey' do
			subject.touch_in
			subject.touch_out
			expect(subject.status).to eq "Touched out"
		end
	end


end