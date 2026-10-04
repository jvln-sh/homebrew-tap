# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.2"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.2/jvlns-osx-arm64.tar.gz"
      sha256 "f57e8b5b4d0de33c6ba81b086f55c53f6cbd68bf104a42a3d79454f856bc242e"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.2/jvlns-osx-x64.tar.gz"
      sha256 "9502c2ca33f9db1c8b9d62cc41389fb8ed21f16f575af41186be15826e607d52"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.2/jvlns-linux-arm64.tar.gz"
      sha256 "4f20b041d0bea225e6155180e118f68ac213bdcafd35aca426b131aab909250e"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.2/jvlns-linux-arm64.tar.gz"
      sha256 "eeba1c680e2fbabb69adcc4fa60c9b34dc61519540ec4bf6554040a34d0f404c"
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
