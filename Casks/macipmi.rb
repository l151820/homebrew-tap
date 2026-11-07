# Wird bei jedem Release automatisch aus MacIPMI/packaging/macipmi.rb.template erzeugt.
cask "macipmi" do
  version "0.4.0"
  sha256 "625d71b71cdbae8449c9eaa8213820dff4994e273bac9319be0a2c6e3fe3aba4"

  url "https://github.com/l151820/MacIPMI/releases/download/v#{version}/MacIPMI-#{version}.zip"
  name "MacIPMI"
  desc "IPMI management and KVM console for Supermicro X9 servers"
  homepage "https://github.com/l151820/MacIPMI"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "MacIPMI.app"
  binary "#{appdir}/MacIPMI.app/Contents/MacOS/ipmi-cli"

  # Die App ist ad-hoc-signiert, aber nicht notarisiert.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MacIPMI.app"],
        writable_paths: ["{{appdir}}/MacIPMI.app"],
        must_succeed:   false
  end

  zap trash: [
    "~/Library/Caches/MacIPMI",
    "~/Library/Caches/tech.rabe.MacIPMI",
    "~/Library/Preferences/tech.rabe.MacIPMI.plist",
    "~/Library/Saved Application State/tech.rabe.MacIPMI.savedState",
  ]
end
