# renames files in directory from "021roman..." to "021_roman..."
files = Dir['*rb'].select {|f| f =~ /^[0-9]{3}[a-zA-Z]+/}

files.each do |f|
  f1 = f.clone
  f2 = f.insert(3, '_')
  system("mv #{f1} #{f2}")
end

# for your fgh example. renames "fgh..." to "jkl..."

files = Dir['fgh*']

files.each do |f|
  f2 = f.gsub('fgh', 'jkl')
  system("mv #{f} #{f2}")
end
