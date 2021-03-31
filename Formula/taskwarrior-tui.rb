class TaskwarriorTui < Formula
  desc "Terminal user interface for taskwarrior"
  homepage "https://github.com/kdheepak/taskwarrior-tui"
  url "https://github.com/kdheepak/taskwarrior-tui/archive/v0.13.0.tar.gz"
  sha256 "95c6f258fa4333b1a2a68ff619cf253018217e89e1eb9ad41c46d48398088f81"
  license "MIT"
  head "https://github.com/kdheepak/taskwarrior-tui.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "261e4442c8c0bc52528cdb62e7a6a82ae2fc999d424dd4f75e51c43c48eddc47"
    sha256 cellar: :any_skip_relocation, big_sur:       "f497c2c1ccbec2905336970883b91e7ec7fffb56950da0c1e3d09b9695a2dd13"
    sha256 cellar: :any_skip_relocation, catalina:      "9e6f8d15c589bfd1fa51272411261d7e81783bc1a17f885cfd813f46db60202b"
    sha256 cellar: :any_skip_relocation, mojave:        "ddba138aea584e6b4ef56cecaa8a862b4cf5ab66cff183919e07ebf717503a4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6350152c07f3a68debce15245dfc6dde3334e25854de3cbe7d0d333d3a978c70"
  end

  depends_on "pandoc" => :build unless Hardware::CPU.arm?
  depends_on "rust" => :build
  depends_on "task"

  def install
    system "cargo", "install", *std_cargo_args
    unless Hardware::CPU.arm?
      args = %w[
        --standalone
        --to=man
      ]
      system "pandoc", *args, "docs/taskwarrior-tui.1.md", "-o", "taskwarrior-tui.1"
      man1.install "taskwarrior-tui.1"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/taskwarrior-tui --version")
    assert_match "The argument '--config <FILE>' requires a value but none was supplied",
      shell_output("#{bin}/taskwarrior-tui --config 2>&1", 1)
  end
end
