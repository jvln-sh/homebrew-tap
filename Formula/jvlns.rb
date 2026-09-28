# SPDX-FileCopyrightText: 2026 Adam Shirt <adamshirt@outlook.com>
# SPDX-FileCopyrightText: 2026 Jvln Contributors
#
# SPDX-License-Identifier: AGPL-3.0-only

class Jvlns < Formula
  desc "Reverse proxy tunnel server for jvln"
  homepage "https://www.jvln.sh"
  version "0.1.1"
  license "AGPL-3.0-only"
  depends_on "libmsquic"

  on_macos do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.1/jvln-server-osx-arm64.tar.gz"
      sha256 "6d6d88f327e3ff6240489aec31ca1207c5bdc83c6badec6e1635485aebdb215a"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.1/jvln-server-osx-x64.tar.gz"
      sha256 "28846b42df0ff6426cac86f2af5c344e5b2b0a7b369291046e042431f52c7d7c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.1/jvln-server-linux-arm64.tar.gz"
      sha256 "6b7a1fcc3b0fa3f232bd8e7e163acb1859052ccf8e4dff59d203decb54fab16c"
    else
      url "https://codeberg.org/drmathias/jvln/releases/download/server@v0.1.1/jvln-server-linux-x64.tar.gz"
      sha256 "42b071347fe9dd4d3a199f17feceaca27a66e64b3315a6c8e1ed67e3446ac1bd"
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

  post_install_steps do
    run "jvlns", args: ["init"], base: :bin
  end

  test do
    system "bin/jvlns", "--version"
  end
end
