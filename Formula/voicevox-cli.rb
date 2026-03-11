class VoicevoxCli < Formula
  desc "CLI tool to control local VoiceVox engine (TTS) from terminal and Claude Code"
  homepage "https://github.com/ymmtr6/voicevox-cli"
  url "https://github.com/ymmtr6/voicevox-cli/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "f1bf96149c3e31c994421d340997eebd67b7c603eef2425e2dc69f1c02c5466f"

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
