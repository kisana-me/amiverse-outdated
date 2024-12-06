module EmojiImport
  require 'open-uri'

  file_path = Rails.root.join('path', 'to', 'emoji-test.txt')
  group = nil
  subgroup = nil

  File.foreach(file_path) do |line|
    line.strip!

    # Detect group
    if line.start_with?('# group:')
      group_name = line.split(':').last.strip
      group = Group.find_or_create_by!(name: group_name)
      next
    end

    # Detect subgroup
    if line.start_with?('# subgroup:')
      subgroup_name = line.split(':').last.strip
      subgroup = Subgroup.find_or_create_by!(name: subgroup_name, group: group)
      next
    end

    # Parse emoji data
    next unless line.match(/; fully-qualified/)

    codepoints, description = line.split('#').map(&:strip)
    emoji_char = [codepoints.split(' ').map { |cp| cp.hex }].pack('U*')
    description_parts = description.split(' ', 2)
    emoji_name = description_parts.last.strip
    name_id = emoji_name.downcase.gsub(/[^a-z0-9]+/, '_')

    Emoji.create!(
      name: emoji_char,
      name_id: name_id,
      group: group,
      subgroup: subgroup
    )
  end
end