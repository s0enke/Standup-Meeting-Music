#!/usr/bin/ruby
songs = File.open("Standupfile").readlines.each{|song|song.chomp! }
random_song = songs[rand(songs.size)]

play_time = ARGV[0].to_i || 10
xvfb = Process.fork do
    exec "Xvfb :99 -ac"
end

firefox = Process.fork do
    exec "DISPLAY=:99 firefox #{random_song}"
end
sleep play_time
Process.kill "TERM", firefox
Process.kill "TERM", xvfb
