class PHP
  def echo string
    puts string
  end

  def function name
    if name != :no_function
      self.class.class_eval do
        define_method name do
          stack[:methods][name][:block].call
        end
      end
    end
  end

  class << self
      public :define_method
  end

  def stack
    @@stack ||= {:classes => {}, :methods => {}}
  end
end

def blue string
   puts "\033[0;34;40m#{string}\033[0m"
end

def red string
   puts "\033[0;31;40m#{string}\033[0m"
end

def method_missing name, *args, &block
  puts ":: #{name} #{args.join(",")} #{block}"
  php = PHP.new
  if php.respond_to? name
    if php.stack[:methods].has_key?(name) && !php.stack[:methods][name][:block].nil? && block_given?
      red "Fatal error: Cannot redeclare #{name}()"
      :no_function
    else
      php.send(name, *args, &block)
    end
  else
    if php.stack.has_key? name
    else
      php.stack[:methods][name] = {:args => args, :block => block}
      blue "mm: #{name.class} #{name}"
    end
    name
  end
end

def to_str
  "#{self}"
end
