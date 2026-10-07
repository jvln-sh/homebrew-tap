# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.4"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.4/jvlns-osx-arm64.tar.gz"
      sha256 "df97e5c49a96418f415e8f5dc5ab9678f83b8efe709bf127a050e47efab2d627"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.4/jvlns-osx-x64.tar.gz"
      sha256 "5590e9b5624d87712aa6c0d6a54113e2f41a97c996059ae8e4528caa91d15069"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.4/jvlns-linux-arm64.tar.gz"
      sha256 "55d888b275a739dc6a2e1f58634ec4a0252bff7e93b7a7a21d24721db2fec8f4"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.4/jvlns-linux-arm64.tar.gz"
      sha256 "78ce2890a684bbe9bec355b4643555c23f499373a9a39582cc44b84d041c9016"
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
