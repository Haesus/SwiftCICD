import ProjectDescription

extension InfoPlist {
  public enum SwiftCICD {
    public static var app: InfoPlist {
      .dictionary(
        [
          "CFBundleDevelopmentRegion": "ko_KR",
          "CFBundleDisplayName": "$(APP_NAME)",
          "CFBundleExecutable": "$(EXECUTABLE_NAME)",
          "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
          "CFBundleInfoDictionaryVersion": "6.0",
          "CFBundleName": "$(PRODUCT_NAME)",
          "CFBundlePackageType": "APPL",
          "CFBundleShortVersionString": "$(MARKETING_VERSION)",
          "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
          "ITSAppUsesNonExemptEncryption": false,
          "LSRequiresIPhoneOS": true,
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": ""
          ],
          "UIUserInterfaceStyle": "Light"
        ]
      )
    }
  }
}
