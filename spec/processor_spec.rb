require_relative "../processor"

RSpec.describe Processor do

  describe "when input from file" do
    it "handles the case when there are 2 people and only 1 relationship" do
      file = Tempfile.new("input.txt")
      File.open(file.path, 'w') do |f|
        f.write("
          2 1
          1 2
        ")
      end

      processor = Processor.new(file.path)
      processor.run

      expected_results = {
        "1" => ["2"],
        "2" => ["1"],
      }
      expect(processor.results).to include(expected_results)
      expect(processor.people).to eq(2)
      expect(processor.relationships).to eq(1)
    end

    it "handles the case when there are 3 people and only 1 relationship" do
      file = Tempfile.new("input.txt")
      File.open(file.path, 'w') do |f|
        f.write("
          3 1
          1 2
          1 3
        ")
      end

      processor = Processor.new(file.path)
      processor.run

      expected_results = {
        "1" => ["2", "3"],
        "2" => ["1"],
        "3" => ["1"],
      }
      expect(processor.results).to include(expected_results)
      expect(processor.people).to eq(3)
      expect(processor.relationships).to eq(1)
    end

    it "handles the case when there are 4 people and 3 relationships" do
      file = Tempfile.new("input.txt")
      File.open(file.path, 'w') do |f|
        f.write("
          4 3
          4 3
          2 4
          2 3
        ")
      end

      processor = Processor.new(file.path)
      processor.run

      expected_results = {
        "4" => ["3", "2"],
        "3" => ["4", "2"],
        "2" => ["4", "3"],
      }
      expect(processor.results).to include(expected_results)
      expect(processor.people).to eq(4)
      expect(processor.relationships).to eq(3)
    end
  end

end
