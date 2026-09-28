# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvln < Formula
  desc "Expose local services to the internet securely"
  homepage "https://www.jvln.sh"
  version "0.1.0"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.0/jvln-osx-arm64.tar.gz"
      sha256 "b9db09f12c90a525e4d180c19a0db1cfd0a54432c1164b4f72d8095d6edbf161"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.0/jvln-osx-x64.tar.gz"
      sha256 "06579f0ded0abe1259fe0d21893a1bd5125894850a336a5a3c940f060ddf59e3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.0/jvln-linux-arm64.tar.gz"
      sha256 "743cc85dd3accbdc5930c0c5fa76eb168cf6791dcbd32a8ae1cf8687115696e8"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/cli@v0.1.0/jvln-linux-x64.tar.gz"
      sha256 "8c74bbd260423673cc269b0a93711937694ab994162a66147efd46788ed1a815"
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
