class Darcs < Formula
  desc "Distributed version control system that tracks changes, via Haskell"
  homepage "http://darcs.net/"
  url "https://hackage.haskell.org/package/darcs-2.16.4/darcs-2.16.4.tar.gz"
  sha256 "e4166252bc403ffc2518edff48801796b8dab73fd9e0da1fcdda916b207fbe1d"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "26d3cc477f82644b7c0c37fafd113d9f78e54dbabf8693c50227b4423e5d193d"
    sha256 cellar: :any_skip_relocation, big_sur:       "e320fccaf6483a2acad3853a76e812f797dd5c9f65c6dd314fb5a8a8f1c174a0"
    sha256 cellar: :any_skip_relocation, catalina:      "312a9c5d7e0c4849fdccefc6c949ebbfb7d5aede071369225ac97f5699a32691"
    sha256 cellar: :any_skip_relocation, mojave:        "e27c0d7e3a7999aabbf51fab11a27558e942848058e4bcffd2dd40a75b157e60"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build
  depends_on "gmp"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    mkdir "my_repo" do
      system bin/"darcs", "init"
      (Pathname.pwd/"foo").write "hello homebrew!"
      system bin/"darcs", "add", "foo"
      system bin/"darcs", "record", "-am", "add foo", "--author=homebrew"
    end
    system bin/"darcs", "get", "my_repo", "my_repo_clone"
    cd "my_repo_clone" do
      assert_match "hello homebrew!", (Pathname.pwd/"foo").read
    end
  end
end
