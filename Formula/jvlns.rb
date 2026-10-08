# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.5"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.5/jvlns-osx-arm64.tar.gz"
      sha256 "99f9760779f604f38ef88a542a3af798fd876352e40c43f866db3d0ec7788368"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.5/jvlns-osx-x64.tar.gz"
      sha256 "069d7abf2f9ac2bac9727638ab35f1c30b415ba2a42f2c4b59e02a43268f0977"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.5/jvlns-linux-arm64.tar.gz"
      sha256 "443c34d7583d900b7b6fea1b290e3dc0661116c1496e1c2f39c0fb27385ef031"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.5/jvlns-linux-arm64.tar.gz"
      sha256 "22119719475990f016bcf5dd9ff7d5bff0b887d1736e93140981613f27fa1897"
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
