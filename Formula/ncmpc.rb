class Ncmpc < Formula
  desc "Curses Music Player Daemon (MPD) client"
  homepage "https://www.musicpd.org/clients/ncmpc/"
  url "https://www.musicpd.org/download/ncmpc/0/ncmpc-0.43.tar.xz"
  sha256 "7abf3c83d3a77c18681a8ce90126c8cb1e1884ebde5be2a735293a4f535ed382"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.musicpd.org/download/ncmpc/0/"
    regex(/href=.*?ncmpc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "eb6dfde7e68a9b4bea16ab8ce081368544e111a12969c2d4787f151a524416fb" => :big_sur
    sha256 "e693f61a2205bf8db4237bbcd28186cdedd9e1b1ab0d3092a943b9084e9030bc" => :arm64_big_sur
    sha256 "918092c3e9b19ca5510cddd48aa571de8023f4d985472208349f7760c9a45148" => :catalina
    sha256 "192cb123d0e9b3ee61ddbe1c1f214c00557784f09812f1eef72b09b9f572207f" => :mojave
    sha256 "26cd03fada1eda2cbe7360372ac9c4b618e9a0cb74b42f8a4550a73faed589c2" => :x86_64_linux
  end

  depends_on "boost" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "libmpdclient"
  depends_on "pcre"
  if OS.mac?
    depends_on "gcc" if DevelopmentTools.clang_build_version <= 800
  else
    fails_with gcc: "5"
    fails_with gcc: "6"
    depends_on "gcc@7"
  end

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dcolors=false", "-Dnls=disabled", ".."
      system "ninja", "install"
    end
  end

  test do
    system bin/"ncmpc", "--help"
  end
end
