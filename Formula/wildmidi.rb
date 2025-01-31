class Wildmidi < Formula
  desc "Simple software midi player"
  homepage "https://www.mindwerks.net/projects/wildmidi/"
  url "https://github.com/Mindwerks/wildmidi/archive/refs/tags/wildmidi-0.4.4.tar.gz"
  sha256 "6f267c8d331e9859906837e2c197093fddec31829d2ebf7b958cf6b7ae935430"
  license all_of: ["GPL-3.0-only", "LGPL-3.0-only"]

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "d3911b6c060df898e6e8e5358a956afaf9bb042083e05be6f7af4f255b80c8bf"
    sha256 cellar: :any,                 big_sur:       "258eb43be9a818dd975315669930ac09bc3c4da1c349e4dfe3c03685dc2b26e4"
    sha256 cellar: :any,                 catalina:      "ca98c79414e1efd3e398c658aa16ede8af301cb46bafede7a8d1cce56bd45f38"
    sha256 cellar: :any,                 mojave:        "48432227a38bc4252423f60d1eb507057ef7212ae01ee27df2a2882de851d893"
  end

  depends_on "cmake" => :build

  def install
    cmake_args = std_cmake_args + %w[
      -S .
      -B build
    ]

    system "cmake", *cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <wildmidi_lib.h>
      #include <stdio.h>
      #include <assert.h>
      int main() {
        long version = WildMidi_GetVersion();
        assert(version != 0);
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lWildMidi"
    system "./a.out"
  end
end
