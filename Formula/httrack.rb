class Httrack < Formula
  desc "Website copier/offline browser"
  homepage "https://www.httrack.com/"
  # Always use mirror.httrack.com when you link to a new version of HTTrack, as
  # link to download.httrack.com will break on next HTTrack update.
  url "https://mirror.httrack.com/historical/httrack-3.49.2.tar.gz"
  sha256 "3477a0e5568e241c63c9899accbfcdb6aadef2812fcce0173688567b4c7d4025"
  revision 1

  livecheck do
    url "https://mirror.httrack.com/historical/"
    regex(/href=.*?httrack[._-]v?(\d+(?:\.\d+)+)\./i)
  end

  bottle do
    sha256 arm64_big_sur: "e33695d628a65bb1c6a5bb5f1147ea4560f8881482e60e10f0a8837527153609"
    sha256 big_sur:       "2f773ea2f9bdf0234abee17e9bd2003f21396fe1fdda756dd6e4faf7844f9c01"
    sha256 catalina:      "291ab06b376233166dd833422801d0a7be6f06cdabdc568656ec64ad3adc5fe8"
    sha256 mojave:        "6e0d2265e15d103a37b6b594f7f10c85af82012f1e3c1e25fc436e7430502b2c"
    sha256 high_sierra:   "612d8c3f9ee15fd7c4f42dbca3c5e3b58e968d626aa15f916f85c8cdb44ea31f"
    sha256 sierra:        "842d48bdb72573623a478a97a2c2abcafe34fb4b0443229216e35d30552dd27f"
    sha256 x86_64_linux:  "5f71e5ffdd78774959dcafa0c8eeaebc8411663c8d1ce02fa8596b2747205f46" # linuxbrew-core
  end

  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    ENV.deparallelize
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
    # Don't need Gnome integration
    rm_rf Dir["#{share}/{applications,pixmaps}"]
  end

  test do
    download = "https://raw.githubusercontent.com/Homebrew/homebrew/65c59dedea31/.yardopts"
    system bin/"httrack", download, "-O", testpath
    assert_predicate testpath/"raw.githubusercontent.com", :exist?
  end
end
