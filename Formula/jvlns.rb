# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.2.0"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.0/jvlns-osx-arm64.tar.gz"
      sha256 "c55b669e193b1900c228090a0d2bf8abb6796e70adde075f606794566ddb88c0"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.0/jvlns-osx-x64.tar.gz"
      sha256 "81bbd2bd35ea59debed4c872bab81b508463e3763826763cebd75a6a5d76daa1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.0/jvlns-linux-arm64.tar.gz"
      sha256 "52254f61c8e029d77fdca7c5e825e77e150f7d91353d36bbcd5a7584266a924b"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.2.0/jvlns-linux-arm64.tar.gz"
      sha256 "f8a7b65a674a4b371adf028596d8693a40086883aa467086ae8ed67ca18ac987"
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
