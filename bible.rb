# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
require 'tmpdir'
require 'fileutils'

class Bible < Formula
  homepage "https://github.com/dtjm/bible"
  url "https://github.com/dtjm/bible.git"
  version "HEAD"

  depends_on "go" => :build
  depends_on "portaudio"
  depends_on "mpg123"

  def install
    Dir.mktmpdir('gopath') {|dir|
      FileUtils.mkpath "#{dir}/src/github.com/dtjm"
      puts "GOPATH=#{dir}"
      ENV['PATH'] = "#{HOMEBREW_PREFIX}/bin:#{ENV['PATH']}"
      ENV['GOPATH'] = "#{dir}:#{dir}/src/github.com/dtjm/bible/Godeps/_workspace"
      ENV['GOBIN'] = "#{dir}/bin"

      File.symlink buildpath, "#{dir}/src/github.com/dtjm/bible"
      system "go", "install", "-v", "github.com/dtjm/bible"
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