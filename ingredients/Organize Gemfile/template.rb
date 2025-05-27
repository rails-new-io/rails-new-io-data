def organize_gemfile_content(content)
  lines = content.split("\n")
  result = { ruby_version: nil, source: nil, git_source: [], top_level_gems: [], groups: {}, other_lines: [] }
  current_group = nil
  
  lines.each do |line|
    clean_line = line.strip
    next if clean_line.empty? || clean_line.start_with?('#')
    
    case clean_line
    when /^ruby\s+/
      result[:ruby_version] = line
    when /^source\s+/
      result[:source] = line
    when /^git_source/
      result[:git_source] << line
    when /^group\s+/
      current_group = clean_line.match(/group\s+(.+?)\s+do/)[1]
      result[:groups][current_group] = []
    when 'end'
      current_group = nil
    when /^gem\s+/
      if current_group
        result[:groups][current_group] << line
      else
        result[:top_level_gems] << line
      end
    else
      result[:other_lines] << line
    end
  end
  
  output = []
  output << result[:source] << "" if result[:source]
  result[:git_source].each { |line| output << line }
  output << "" unless result[:git_source].empty?
  output << result[:ruby_version] << "" if result[:ruby_version]
  
  unless result[:top_level_gems].empty?
    result[:top_level_gems].sort_by { |line| line.match(/gem\s+['"]([^'"]+)['"]/)[1].downcase }.each { |gem| output << gem }
    output << ""
  end
  
  result[:groups].keys.sort.each do |group_name|
    gems = result[:groups][group_name]
    next if gems.empty?
    output << "group #{group_name} do"
    gems.sort_by { |line| line.match(/gem\s+['"]([^'"]+)['"]/)[1].downcase }.each { |gem| output << "  #{gem.strip}" }
    output << "end" << ""
  end
  
  result[:other_lines].each { |line| output << line }
  output << "" unless result[:other_lines].empty?
  
  while output.last&.empty?
    output.pop
  end
  
  output.join("\n") + "\n"
end

original_content = File.read('Gemfile')
organized_content = organize_gemfile_content(original_content)
File.write('Gemfile', organized_content)