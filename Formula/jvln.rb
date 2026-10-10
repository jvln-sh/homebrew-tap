# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvln < Formula
  desc "Expose local services to the internet securely"
  homepage "https://www.jvln.sh"
  version "0.2.0"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.0/jvln-osx-arm64.tar.gz"
      sha256 "f9f9642d60d602589c9542724551c2a47b4117e06077082e142f870a3ee1f6a1"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.0/jvln-osx-x64.tar.gz"
      sha256 "2749df31301c85b34c5b2d5e558d23de7324032cf37c126c866248ae9f770f99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.0/jvln-linux-arm64.tar.gz"
      sha256 "aa976a37d133d9f8c212cbe3abb83ed6e1cf09b16ae6d9e6c63a39d997994ecc"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.0/jvln-linux-x64.tar.gz"
      sha256 "9e8969981496694719ab3f836a501681e345c749c2f7366df2c374b335efa38e"
    end
  end

  def install
    if OS.mac?
      libexec.install "jvln"
      (bin/"jvln").write <<~EOS
        #!/bin/bash
        export DYLD_FALLBACK_LIBRARY_PATH="#{HOMEBREW_PREFIX}/lib:$DYLD_FALLBACK_LIBRARY_PATH"
        exec "#{libexec}/jvln" "$@"
      EOS
    else
      bin.install "jvln"
    end
  end

  test do
    system "bin/jvln", "--version"
  end
end
