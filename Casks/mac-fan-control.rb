cask "mac-fan-control" do
  version "1.1.0"
  sha256 "f016cce5855ade98fde7f32845110f5dddee38ab2aded8de7ef63db2bacac61c"

  url "https://github.com/saltui/mac-fan-control/releases/download/v#{version}/FanControl-#{version}.zip"
  name "Mac Fan Control"
  desc "Lightweight menu bar fan speed control for Apple Silicon Macs"
  homepage "https://github.com/saltui/mac-fan-control"

  depends_on macos: ">= :ventura"

  app "FanControl.app"

  postflight do
    set_permissions "/Applications/FanControl.app/Contents/MacOS/FanControl-bin", "0755"
  end

  caveats <<~EOS
    FanControl needs root access for SMC control.
    Run this once to enable passwordless sudo:

      echo "$(whoami) ALL=(ALL) NOPASSWD: /Applications/FanControl.app/Contents/MacOS/FanControl-bin" | sudo tee /etc/sudoers.d/fancontrol
      sudo chmod 0440 /etc/sudoers.d/fancontrol

    To auto-start on login, see: https://github.com/saltui/mac-fan-control#auto-start-on-login
  EOS

  zap trash: [
    "~/Library/LaunchAgents/com.jaden.fancontrol.plist",
    "/etc/sudoers.d/fancontrol",
  ]
end
