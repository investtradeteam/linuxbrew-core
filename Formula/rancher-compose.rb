class RancherCompose < Formula
  desc "Docker Compose compatible client to deploy to Rancher"
  homepage "https://github.com/rancher/rancher-compose"
  url "https://github.com/rancher/rancher-compose/archive/v0.12.5.tar.gz"
  sha256 "cdff53b2c3401b990ad33e229c7ef429504419e49e18a814101e2fa3c84859ea"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "86aea676688b0a7af232731acfcf7894a957c5566cd34b793d31f45cecfbde5c"
    sha256 cellar: :any_skip_relocation, big_sur:       "e3993eaca43eae5d57bbe0f2eb6dda444e30f490cf7b1165f723ec086cd0f149"
    sha256 cellar: :any_skip_relocation, catalina:      "50da809ea2a33343eda8099715391efc6c730b6996476d7c5366fba0d52ab853"
    sha256 cellar: :any_skip_relocation, mojave:        "bf318932b401481ee6e3a94c82c617b21e558406ebef9739c1c7bb42441e9eda"
    sha256 cellar: :any_skip_relocation, high_sierra:   "63f6da5eb59cb86c8f84975b3d3ee41f0bfc1456b239d1a6cc06a648d57e1967"
    sha256 cellar: :any_skip_relocation, sierra:        "08f3fad4e6c1df545dd908b61afe47ed489e682ad2cadab384066237498a2a04"
    sha256 cellar: :any_skip_relocation, el_capitan:    "8503ea7d7ca208ca7fe8d0c0b81f9ab9b69d926c58f856ac9de4f9f3600cde17"
    sha256 cellar: :any_skip_relocation, yosemite:      "23291133a0a775210ae1244ae594931ce04fab8e7c0a37ba90431d61d869317b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "faf44369ddd3b4e994478751d1076b59aa6664cb433acb5ca5a6c6b0405a35c5" # linuxbrew-core
  end

  deprecate! date: "2020-10-18", because: :repo_archived

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/rancher/rancher-compose").install Dir["*"]
    system "go", "build", "-ldflags",
           "-w -X github.com/rancher/rancher-compose/version.VERSION=#{version}",
           "-o", "#{bin}/rancher-compose",
           "-v", "github.com/rancher/rancher-compose"
    prefix.install_metafiles "src/github.com/rancher/rancher-compose"
  end

  test do
    system bin/"rancher-compose", "help"
  end
end
