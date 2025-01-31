class Cocot < Formula
  desc "Code converter on tty"
  homepage "https://vmi.jp/software/cygwin/cocot.html"
  url "https://github.com/vmi/cocot/archive/cocot-1.2-20171118.tar.gz"
  sha256 "b718630ce3ddf79624d7dcb625fc5a17944cbff0b76574d321fb80c61bb91e4c"
  license "BSD-3-Clause"
  head "https://github.com/vmi/cocot.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "835a54f7142add9b9a3ab35097a6821fc9c100568b54c2d7fa52c283fd5ca6af"
    sha256 cellar: :any_skip_relocation, big_sur:       "2b1f6c60de8b11f5c3a3c454f30f551d2faf251185cfefacba11adbf61c12aaa"
    sha256 cellar: :any_skip_relocation, catalina:      "c56c078fce103138a45bd1c715dc3854b9eddf207575fada0e736b866d4f46bb"
    sha256 cellar: :any_skip_relocation, mojave:        "c5b0aa39597693d037438bd0f411965754539aaf50fbb2cb3b2a61082b6f4178"
    sha256 cellar: :any_skip_relocation, high_sierra:   "0070eb38e06043e3c1a4ad1b77205a6ed978ed300e8d0bb407391fecb191b050"
    sha256 cellar: :any_skip_relocation, sierra:        "a91ba93032e33b6a062b82f2df0b9170d5269cf0312d75eb6f16341fca54f9bd"
    sha256 cellar: :any_skip_relocation, el_capitan:    "60cbdadb074b019535319e5089d5c55c43b68e0b52a73b01cec3a9a8311e51a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ebf62b8bae739c78d96ebe840e53d06d7088421519c7b634deb6c4ed386842c" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
