class Apngasm < Formula
  desc "Next generation of apngasm, the APNG assembler"
  homepage "https://github.com/apngasm/apngasm"
  url "https://github.com/apngasm/apngasm/archive/3.1.6.tar.gz"
  sha256 "0068e31cd878e07f3dffa4c6afba6242a753dac83b3799470149d2e816c1a2a7"
  license "Zlib"
  revision 3
  head "https://github.com/apngasm/apngasm.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e7ae49e492cf07670d473742b64ab25103e0e94780181b78173c10b5f5c4fba7"
    sha256 cellar: :any,                 big_sur:       "d94b80958f9782e98a7bcd7461b22d5239c376d4b1fb26b49bfb9d5c5c25b6e6"
    sha256 cellar: :any,                 catalina:      "db0dc40f3fd4e8a8b7435da56211356e669b42ba47b8107d0f840777197202cf"
    sha256 cellar: :any,                 mojave:        "569b760c848add596a639397ebe63f631e2ad3faabd1fa77ea6609f24f240e2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd723c581739c21323fcba6aaf920532144aac609a0f7b30d124fc69f0487d9c" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libpng"
  depends_on "lzlib"

  def install
    inreplace "cli/CMakeLists.txt", "${CMAKE_INSTALL_PREFIX}/man/man1",
                                    "${CMAKE_INSTALL_PREFIX}/share/man/man1"
    mkdir "build" do
      ENV.cxx11
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
    (pkgshare/"test").install "test/samples"
  end

  test do
    system bin/"apngasm", "#{pkgshare}/test/samples/clock*.png"
  end
end
