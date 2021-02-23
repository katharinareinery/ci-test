require 'rake/clean'

CC          = ENV['CC'] ? ENV['CC'] : 'cc'
CFLAGS      = '-Wall -O2'

TINYAES_DIR = 'lib/tinyAES'
UNITY_DIR   = 'lib/Unity/src'

CLEAN.include('**/*.o', '**/*.exe')

source_files = Rake::FileList['src/*.c']
bin_files = source_files.ext('.exe')

tinyAES_files = Rake::FileList[TINYAES_DIR + '/*.c']
tinyAES_obj_files = tinyAES_files.ext('.o').exclude(/test.*/)

unity_files = Rake::FileList[UNITY_DIR + '/*.c']
unity_obj_files = unity_files.ext('.o')

desc 'Build tinyAES files'
task :tinyAES => tinyAES_obj_files

desc 'Build Unity files'
task :Unity => unity_obj_files

desc "
Build all test executables at once. Individual test cases can be built using
  * rake src/test1.exe
  * rake src/test2.exe
  * rake src/test3.exe
"
task :tests => [:tinyAES, :Unity] + bin_files

rule '.o' => '.c' do |task|
  begin
    sh "#{CC} #{CFLAGS} -I#{TINYAES_DIR} -I#{UNITY_DIR} -c #{task.source} -o #{task.name}"
  rescue
    print "Error while building #{task.source}"
  end
end

rule '.exe' => '.o' do |task|
  begin
    sh "#{CC} #{CFLAGS} -I#{TINYAES_DIR} -I#{UNITY_DIR} #{tinyAES_obj_files.to_a.join(' ')} #{unity_obj_files.to_a.join(' ')} #{task.source} -o #{task.name}"
  rescue
    print "Error while linking #{task.source}"
  end  
end

desc 'Create tests'
task :default => :tests
