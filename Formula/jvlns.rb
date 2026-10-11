# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.2.1"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.1/jvlns-osx-arm64.tar.gz"
      sha256 "dfed9d8ea5bb53430ba43eb9b705807c82b3b9017794eb91da774bcc39bbaf76"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.1/jvlns-osx-x64.tar.gz"
      sha256 "72fd9bf9a1381cb9779a8e8916b012ba87c76f853096ae2a0e4323b5d6918560"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.1/jvlns-linux-arm64.tar.gz"
      sha256 "456b954c6105cb7e7041718d30b9d9dea3956f3431e8abc45d4580f2b950e404"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.1/jvlns-linux-arm64.tar.gz"
      sha256 "3d042fb6ba36e369ef9fae653d1cd6d2929a2c934f7fb7050bb6e32953125b71"
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
