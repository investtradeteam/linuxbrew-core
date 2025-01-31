class Taskd < Formula
  desc "Client-server synchronization for todo lists"
  homepage "https://taskwarrior.org/docs/taskserver/setup.html"
  url "https://taskwarrior.org/download/taskd-1.1.0.tar.gz"
  sha256 "7b8488e687971ae56729ff4e2e5209ff8806cf8cd57718bfd7e521be130621b4"
  license "MIT"
  revision 1
  head "https://github.com/GothenburgBitFactory/taskserver.git", branch: "1.2.0"

  livecheck do
    url "https://taskwarrior.org/download/"
    regex(/href=.*?taskd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "538ccd42a9ccb36722a35116bb1652217eeb33813683e14d194a3a8aab33bf35"
    sha256 cellar: :any,                 big_sur:       "842ffc8f10936b3803281743196d37571057656ccfcd019364b8c5114ddc36cd"
    sha256 cellar: :any,                 catalina:      "88580976ecb71d4f74d814ff06c88c2082565fee61c7ff8e7f506bce19b460d4"
    sha256 cellar: :any,                 mojave:        "225bedd463f0344572ec985bbb49693dc0b6d5c095c87a5157bcfc437317c1d7"
    sha256 cellar: :any,                 high_sierra:   "f9737943f0b2877414bf8c0d957a88d79010334a145be6420fd93f64b9569cb3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc88eb1503afa1c0f181748e427e681fada36622c430c0c2b96e3ec39d67104f" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "gnutls"

  on_linux do
    depends_on "util-linux"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/taskd", "init", "--data", testpath
  end
end
