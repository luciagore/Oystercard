require 'Journey'

describe Journey do
	let(:ent_station) {double :station}
	let(:ext_station) {double :station}
	it 'starting station' do
		subject.start(ent_station)
		expect(subject.start_station).to eq ent_station
	end
	it 'ending station' do
		subject.end(ext_station)
		expect(subject.exit_station).to eq ext_station
	end
	describe '#complete?' do
		it 'journey_complete at default' do
			expect(subject).to_not be_complete
		end
		it 'journey complete at touch_in' do
			subject.start(ent_station)
			expect(subject).to_not be_complete
		end

		it 'journey complete at touch_out' do
			subject.end(ext_station)
			expect(subject).to_not be_complete
		end

		it 'journey complete at touch_in and touh out' do
			subject.start(ent_station)
			subject.end(ext_station)
			expect(subject).to be_complete
		end
	end

	describe '#fare' do
		it 'charges min fare at complete' do
			subject.start(ent_station)
			subject.end(ext_station)
			expect(subject.fare).to eq Journey::MIN_FARE
		end
		it 'charges penalty fare at incomplete' do
			j1 = Journey.new
			j1.start(ent_station)
			expect(j1.fare).to eq Journey::PENALTY_FARE

			j2 = Journey.new
			j2.end(ext_station)
			expect(j2.fare).to eq Journey::PENALTY_FARE
		end
	end
end
