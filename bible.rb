# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
require 'tmpdir'

class Bible < Formula
  homepage "https://github.com/dtjm/bible"
  url "https://github.com/dtjm/bible"
  sha1 "923bf747f0a90011be27f1a423aa66db2464e1c2"
  version "0.0.4"

  # depends_on "cmake" => :build
  depends_on "go" # if your formula requires any X11/XQuartz components
  depends_on "portaudio"
  depends_on "mpg123"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    Dir.mktmpdir('gopath') {|dir|
      puts "GOPATH=#{dir}"
      puts "PATH=#{ENV['PATH']}"
      ENV['PATH'] = "/usr/local/bin:#{ENV['PATH']}"
      ENV['GOPATH'] = dir
      ENV['GOBIN'] = "#{dir}/bin"
      system "go", "get", "-v", "github.com/dtjm/bible"
      bin.install "#{dir}/bin/bible"
    }
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test bible`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end