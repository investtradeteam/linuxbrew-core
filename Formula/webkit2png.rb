class Webkit2png < Formula
  desc "Create screenshots of webpages from the terminal"
  homepage "https://www.paulhammond.org/webkit2png/"
  url "https://github.com/paulhammond/webkit2png/archive/v0.7.tar.gz"
  sha256 "9b810edb6f54cc23ba86b0212f203e6c3bbafc3cbdb62b9c33887548c91015bf"
  license "MIT"

  # Requires Quartz, as well as other potentially Mac-only libraries
  depends_on :macos

  def install
    bin.install "webkit2png"
  end

  test do
    system "#{bin}/webkit2png", "--version"
  end
end
