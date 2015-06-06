require 'dupey_bookey'

RSpec.describe DupeyBookey do
  describe '#dupes' do
    context 'provites empty list when' do
      it 'recieves no data in the list' do
        data = '[{}]'

        result = subject.dupes(data)

        expect(result).to be_empty
      end

      it 'recieves is an empty list' do
        data = '[]'

        result = subject.dupes(data)

        expect(result).to be_empty
      end

      it 'recieves data without a title field' do
        data = '[{ "some_field": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to be_empty
      end

      it 'recieves data with the title only once' do
        data = '[{ "title": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to be_empty
      end

      it 'recieves data that has multiple books only listed once' do
        data = '[{ "title": "The Agile Samurai" }, { "title": "Another book"}]'

        result = subject.dupes(data)

        expect(result).to be_empty
      end
    end

    context 'provides the title' do
      it 'has the same title twice' do
        data = '[{ "title": "The Agile Samurai" }, { "title": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to have_key("the agile samurai")
      end

      it 'has the the same title twice, ignoring case' do
        data = '[{ "title": "The AGILE SaMurai" }, { "title": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to have_key("the agile samurai")
      end

      it 'has a similar spelt title' do
        data = '[{ "title": "The AGILE SaMurai" }, { "title": "The Agle Smurai" }]'

        result = subject.dupes(data)

        expect(result).to have_key("the agile samurai")
      end
    end
  end
end
