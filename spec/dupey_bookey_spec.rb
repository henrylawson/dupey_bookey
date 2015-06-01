require 'dupey_bookey'

RSpec.describe DupeyBookey do
  describe '#dupes' do
    it 'provides empty list, with no data when no data is empty' do
      data = '[{}]'

      result = subject.dupes(data)

      expect(result).to be_empty
    end

    it 'provides empty list when no data is empty' do
      data = '[]'

      result = subject.dupes(data)

      expect(result).to be_empty
    end

    it 'provides empty list when only a single book' do
      data = '[ { "title": "The Agile Samurai" }]'

      result = subject.dupes(data)

      expect(result).to be_empty
    end

    it 'provides empty list when title is not available' do
      data = '[ { "some_field": "The Agile Samurai" }]'

      result = subject.dupes(data)

      expect(result).to be_empty
    end

    context 'provides the title' do
      it 'has the same title twice' do
        data = '[ { "title": "The Agile Samurai" }, { "title": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to include("The Agile Samurai")
      end

      it 'has the the same title twice, ignoring case' do
        data = '[ { "title": "The AGILE SaMurai" }, { "title": "The Agile Samurai" }]'

        result = subject.dupes(data)

        expect(result).to include("The Agile Samurai")
      end

      it 'has a similar spelt title' do
        data = '[ { "title": "The AGILE SaMurai" }, { "title": "The Agle Smurai" }]'

        result = subject.dupes(data)

        expect(result).to include("The Agile Samurai")
      end
    end
  end
end
