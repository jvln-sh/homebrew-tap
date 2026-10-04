# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.3"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.3/jvlns-osx-arm64.tar.gz"
      sha256 "10cfbc872174d90fc352b3240c5ac7b26b77bf83ad0be8c98150be2af3382c47"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.3/jvlns-osx-x64.tar.gz"
      sha256 "78f5bb956226aefbd8d8d1a879d84b716ef7fe9107ee851639326d11e668e9cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.3/jvlns-linux-arm64.tar.gz"
      sha256 "bee44d3433008c4c897b7aae3fa5d56d201204ea383d9a93c88e3ebc7661f527"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.3/jvlns-linux-arm64.tar.gz"
      sha256 "4f69c1f7c6dd87fc8fc345cf4ec8ce3c0223f4a68de5cf0f7be9e9c230c39b32"
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
