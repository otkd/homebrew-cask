cask "lbry" do
  version "0.52.2"
  sha256 "0eb5ef6c428a1860a82ef13567f3b44b4ef2c52425c82d55d40af3952f538801"

  url "https://github.com/lbryio/lbry-desktop/releases/download/v#{version}/LBRY_#{version}.dmg",
      verified: "github.com/lbryio/lbry-desktop/"
  name "LBRY Desktop"
  desc "Official client for LBRY, a decentralised file-sharing and payment network"
  homepage "https://lbry.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :mojave"

  app "LBRY.app"
  # shim scripts (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shim_lbrynet = "#{staged_path}/lbrynet.wrapper.sh"
  shim_lbryfirst = "#{staged_path}/libry-first.wrapper.sh"
  binary shim_lbrynet, target: "lbrynet"
  binary shim_lbryfirst, target: "lbry-first"

  preflight do
    File.write shim_lbrynet, <<~EOS
      #!/bin/sh
      exec '#{appdir}/LBRY.app/Contents/Resources/static/daemon/lbrynet' "$@"
    EOS

    File.write shim_lbryfirst, <<~EOS
      #!/bin/sh
      exec '#{appdir}/LBRY.app/Contents/Resources/static/lbry-first/lbry-first' "$@"
    EOS
  end

  zap trash: [
    "~/Library/Application Support/lbry",
    "~/Library/Preferences/io.lbry.LBRY.plist",
    "~/Library/Saved Application State/io.lbry.LBRY.savedState",
  ]
end
