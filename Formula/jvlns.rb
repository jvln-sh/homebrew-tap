# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.6"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.6/jvlns-osx-arm64.tar.gz"
      sha256 "71aa10fe3b665c4cd27212cf6c38b814a0be767b7dbc71f872251284061996f5"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.6/jvlns-osx-x64.tar.gz"
      sha256 "ac2c0e5592f28a8844c2dc9c4322e1036b35fe52f5d7b037e5dfb76172e8d517"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.6/jvlns-linux-arm64.tar.gz"
      sha256 "3f45e11d9a2bebf0c7207a47ac7fa79ddd186abed17ae465f3d23073be31074c"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.6/jvlns-linux-arm64.tar.gz"
      sha256 "2bc45ae443da67312d4ff80eb351b3f2f69171f520199b11dd507c0438041959"
    end
  end

  def install
    if OS.mac?
      libexec.install "jvlns"
      (bin/"jvlns").write <<~EOS
        #!/bin/bash
        export DYLD_FALLBACK_LIBRARY_PATH="#{HOMEBREW_PREFIX}/lib:$DYLD_FALLBACK_LIBRARY_PATH"
        exec "#{libexec}/jvlns" "$@"
      EOS
    else
      bin.install "jvlns"
    end
  end

  test do
    system "bin/jvlns", "--version"
  end
end
