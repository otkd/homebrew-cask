cask "zalo" do
  version "21.12.1"
  sha256 "64e9b32a170e588397157c98a79e08ea52b639701eb00afb18b792646d7585ff"

  url "https://res-zaloapp-aka.zdn.vn/mac/ZaloSetup-#{version}.dmg#",
      verified: "res-zaloapp-aka.zdn.vn/mac/"
  name "Zalo"
  desc "Messaging and calling application"
  homepage "https://zalo.me/"

  livecheck do
    url "https://zalo.me/download/zalo-pc"
    strategy :header_match
  end

  app "Zalo.app"

  zap trash: [
    "~/Library/Application Support/Zalo",
    "~/Library/Application Support/ZaloPC",
    "~/Library/Preferences/com.vng.zalo.*.plist",
    "~/Library/Saved Application State/com.vng.zalo.savedState",
  ]
end
