require 'fileutils'

path = File.dirname(__FILE__)
makefile = "#{path}/Makefile"

if RUBY_PLATFORM.downcase =~ /darwin/
  FileUtils.cp("#{path}/Makefile.mac", makefile)
else
  FileUtils.cp("#{path}/Makefile.linux", makefile)
end

$makefile_created = true