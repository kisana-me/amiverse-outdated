class ImportUnicodeEmojiJob < ApplicationJob
  include Tools
  queue_as :default

  def perform()
    file = Rails.root.join('storage', 'emoji-test1.txt')
    group = nil
    subgroup = nil

    File.foreach(file) do |line|
      line.strip!

      # Detect group
      if line.start_with?('# group:')
        group = line.split(':').last.strip
        next
      end

      # Detect subgroup
      if line.start_with?('# subgroup:')
        subgroup = line.split(':').last.strip
        next
      end

      # Parse emoji data
      next unless line.match(/; fully-qualified/)

      codepoints, description = line.split('#', 2).map(&:strip)
      description_parts = description.split(' ', 3)
      emoji_char = description_parts.first.strip
      emoji_ver = description_parts[1].strip
      emoji_name = description_parts.last.strip
      name_id = emoji_name.downcase.gsub(/[^a-z0-9]+/, '_')

      Emoji.find_or_create_by(
        account: Account.first,
        aid: generate_aid(Emoji, 'aid'),
        name: emoji_char,
        name_id: name_id,
        description: emoji_ver,
      )
      puts(
        name: emoji_char,
        name_id: name_id,
        ver: emoji_ver,
        group: group,
        subgroup: subgroup
      )
    end

    puts 'Emoji data imported successfully!'
  end
end