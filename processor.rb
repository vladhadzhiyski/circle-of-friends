class Processor
  attr_reader :people, :results, :relationships

  def initialize(filepath)
    @people = 0
    @relationships = 0
    @results = {}
    @filepath = filepath
  end

  def run
    File.foreach(@filepath) do |line|
      input = line.strip
      next if input.empty?
      input_items = input.split(" ")
      if @people == 0
        @people = input_items[0].to_i
        @relationships = input_items[1].to_i
      else
        friend_x = input_items[0]
        friend_y = input_items[1]
        create_friendship(friend_x, friend_y)
      end
    end
  end

  def print_output
    @people.times do |index|
      person = (index + 1).to_s
      relationships_count = @results[person].nil? ? 0: @results[person].count
      print "#{relationships_count} "
    end
    puts "\n"
  end

  private

    def create_friendship(friend_x, friend_y)
      @results[friend_x] ||= [friend_y]
      @results[friend_y] ||= [friend_x]
      @results[friend_x] << friend_y unless @results[friend_x].include?(friend_y)
      @results[friend_y] << friend_x unless @results[friend_y].include?(friend_x)
    end
end
