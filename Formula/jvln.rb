# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvln < Formula
  desc "Expose local services to the internet securely"
  homepage "https://www.jvln.sh"
  version "0.2.1"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.1/jvln-osx-arm64.tar.gz"
      sha256 "d671b0ebac96b8859b71c68da2511d0a66bf81244abd935c367a4b3280a25a4b"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.1/jvln-osx-x64.tar.gz"
      sha256 "8c60946d618676ff210e65c184171127b34cbd443c0257bba4ba3d88cf30cc13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.1/jvln-linux-arm64.tar.gz"
      sha256 "8ae4f80c403ff46bc3319ded5177defce0f52c927e5cd099f8aec8ecfa2656c4"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.2.1/jvln-linux-x64.tar.gz"
      sha256 "ffdb3be5d7d44b749e27345ea7abc44ff826675b2480624574bdb1e3e4ff15d4"
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
