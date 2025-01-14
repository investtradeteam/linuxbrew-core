class Binaryen < Formula
  desc "Compiler infrastructure and toolchain library for WebAssembly"
  homepage "https://webassembly.org/"
  url "https://github.com/WebAssembly/binaryen/archive/version_102.tar.gz"
  sha256 "6197a8d7220d1510bb0694a2984bfae4f8b38abd6bdf4c724551c831786992f6"
  license "Apache-2.0"
  head "https://github.com/WebAssembly/binaryen.git", branch: "main"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e00fd13945ddfa707b35a2fd6b7bd20e5c1fa99fb4574ad7b52607160ead74f7"
    sha256 cellar: :any,                 big_sur:       "580bcfb61bdf0ef6fea0b92af3428ee3484b47a87eb2bf9cee4602a5aec5b3c8"
    sha256 cellar: :any,                 catalina:      "8dc80e3e1d1a6de47acfd1d107cdea836d2a81ea0bee7fe117423052eacc4558"
    sha256 cellar: :any,                 mojave:        "3fbf167d4e89a81d052375286fd46f8e8604ef5875f96336c9ed13fd4a8737a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "552547c2cab2629e7e8af19977810cd5c1d42afa5d167cf71d6c48a4a088e725" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "python@3.9" => :build

  on_linux do
    depends_on "gcc"
  end

  fails_with gcc: "5"

  def install
    ENV.cxx11

    system "cmake", ".", *std_cmake_args
    system "make", "install"

    pkgshare.install "test/"
  end

  test do
    system "#{bin}/wasm-opt", "-O", "#{pkgshare}/test/passes/O1_print-stack-ir.wast", "-o", "1.wast"
    assert_match "stacky-help", File.read("1.wast")
  end
end
