class VoicevoxCli < Formula
  desc "CLI tool to control local VoiceVox engine (TTS) from terminal and Claude Code"
  homepage "https://github.com/ymmtr6/voicevox-cli"
  url "https://github.com/ymmtr6/voicevox-cli/archive/refs/tags/v1.0.13.tar.gz"
  sha256 "55e098d499c9d8ec938bac7f38ae21c3251ef3159b8a0bbcefe3dc4651e17d31"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    system "npm", "run", "build"

    libexec.install "dist", "node_modules", "package.json", "skills"

    (bin/"voicevox-cli").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "voicevox-cli", shell_output("#{bin}/voicevox-cli --help")
  end
end
