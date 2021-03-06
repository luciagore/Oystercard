require 'Journeylog'
describe Journeylog do 
	let (:d_journey_class) {double :Journey_class}
	let (:d_journey) {double :Journey}
	let (:d_start_station) {double :station}
	let (:d_exit_station) {double :station}
	let (:d_card) {double :Oystercard}
	subject { described_class.new(d_journey_class)}
	
	
	

	it 'holds a journey' do
		allow(d_journey_class).to receive(:new).and_return(d_journey)
		
		expect(subject.log) == []
	end

	it '#start' do
		allow(d_journey_class).to receive(:new).and_return(d_journey)
		allow(d_journey).to receive(:start).with(d_start_station).and_return(nil)

		subject.start(d_start_station)
		
		expect(subject.journeys).to include(d_journey)
	end

	it "#finish" do
		allow(d_journey_class).to receive(:new).and_return(d_journey)
		allow(d_journey).to receive(:start).with(d_start_station).and_return(nil)
		allow(d_journey).to receive(:end).with(d_exit_station).and_return(nil)
		allow(d_journey).to receive(:fare).and_return(Journey::MIN_FARE)

		allow(d_journey).to receive(:complete?).and_return(true)

		subject.start(d_start_station)

		subject.finish(d_exit_station)

		expect(subject.journeys).to include(d_journey)

	end

	it "#journeys" do
		expect(subject.journeys).to be_empty
	end


end
