def method_missing name, *args, &block
  puts "---"
  puts name
  line = caller.first.match(/:(\d+):/)[1].to_i
  puts "#{line}: #{File.readlines("example.php")[line - 1]}"
end

load "example.php"
