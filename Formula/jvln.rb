# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvln < Formula
  desc "Expose local services to the internet securely"
  homepage "https://www.jvln.sh"
  version "0.1.1"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.1/jvln-osx-arm64.tar.gz"
      sha256 "64950fa4449b4dba1733ae5d2755c695e5ba7eeab7db9141ea167fa7e4a5a090"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.1/jvln-osx-x64.tar.gz"
      sha256 "81505b2ac500204d432645ef733f50d2682e9a12b6f3f1918916a6387b10c532"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.1/jvln-linux-arm64.tar.gz"
      sha256 "243d0ee8d229c6c36d20de28f3c7d6abf9566354f1f11d5933330f044ac2911a"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.1/jvln-linux-x64.tar.gz"
      sha256 "6fd3113436fb70c402978b60115482585290b0fded63bd22d539f0f90aa9d47e"
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
