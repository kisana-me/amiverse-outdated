require 'natto'

class WordCounterService
  def initialize
    @natto = Natto::MeCab.new
  end

  def frequent_words(posts)
    word_count = Hash.new(0)
    stop_words = %w[0 1 2 3 4 5 6 ？ ！]

    posts.each do |post|
      @natto.parse(post.content) do |n|
        if n.surface.length > 1 
          word_count[n.surface] += 1
        end
      end
    end

    word_count.sort_by { |_, count| -count }.to_h
  end
end
