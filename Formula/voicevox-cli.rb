class VoicevoxCli < Formula
  desc "CLI tool to control local VoiceVox engine (TTS) from terminal and Claude Code"
  homepage "https://github.com/ymmtr6/voicevox-cli"
  url "https://github.com/ymmtr6/voicevox-cli/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "a08a0e75b1d46697cf7f3b977fbf7abe664b7c9245d9ed323bb7a2f919c054f9"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    system "npm", "run", "build"

    libexec.install "dist", "node_modules", "package.json"

    (bin/"voicevox-cli").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "voicevox-cli", shell_output("#{bin}/voicevox-cli --help")
  end
end
