class VoicevoxCli < Formula
  desc "CLI tool to control local VoiceVox engine (TTS) from terminal and Claude Code"
  homepage "https://github.com/ymmtr6/voicevox-cli"
  url "https://github.com/ymmtr6/voicevox-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "55940347d640dc53d68d0eca625e0bfcaa5945b12c1d0e859b0b7e2f0da4f766"

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
