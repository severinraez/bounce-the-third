task :install do
  puts "Installing bundle ..."
  system "bundle install > /dev/null"
  puts "Installing bourbon ..."
  system "bourbon install --path source/stylesheets/vendor > /dev/null"
end

task :update do
  puts "Updating bundle ..."
  system "bundle install > /dev/null"
  puts "Updating bourbon ..."
  system "bourbon update --path source/stylesheets/vendor > /dev/null"
  puts "Updating jQuery ..."
  system "curl -o build/javascripts/jquery.min.js http://code.jquery.com/jquery-latest.min.js > /dev/null"
end