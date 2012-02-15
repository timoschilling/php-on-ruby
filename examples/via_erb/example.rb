load "../../lib/php.rb"

require "erb"

puts ERB.new(File.read("example.php")).result
