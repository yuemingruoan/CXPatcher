import XCTest
@testable import CXPatcher

final class CrossoverCompatibilityTests: XCTestCase {
    private func makeFakeCrossOverApp(version: String, bundleId: String = "com.codeweavers.CrossOver") throws -> URL {
        let tempDir = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let appURL = tempDir.appendingPathComponent("CrossOver.app", isDirectory: true)
        let contentsURL = appURL.appendingPathComponent("Contents", isDirectory: true)
        try FileManager.default.createDirectory(at: contentsURL, withIntermediateDirectories: true)

        let plist: [String: String] = [
            "CFBundleIdentifier": bundleId,
            "CFBundleShortVersionString": version,
        ]
        let plistData = try PropertyListSerialization.data(
            fromPropertyList: plist,
            format: .xml,
            options: 0
        )
        let plistURL = contentsURL.appendingPathComponent("Info.plist")
        try plistData.write(to: plistURL)
        return appURL
    }

    func testCrossOver26IsAccepted() throws {
        let appURL = try makeFakeCrossOverApp(version: "26.0")
        XCTAssertTrue(isCrossoverApp(url: appURL, skipVersionCheck: false))
    }

    func testCrossOver25IsRejected() throws {
        let appURL = try makeFakeCrossOverApp(version: "25.0")
        XCTAssertFalse(isCrossoverApp(url: appURL, skipVersionCheck: false))
    }

    func testExternalResourcesRootTargetsAppleGptk() {
        XCTAssertEqual(EXTERNAL_RESOURCES_ROOT, "/lib64/apple_gptk")
    }

    func testDxvkPathTargetsV26LayoutOnly() {
        XCTAssertTrue(WINE_RESOURCES_PATHS.contains("/lib/dxvk"))
        XCTAssertFalse(WINE_RESOURCES_PATHS.contains("/lib/wine/dxvk"))
        XCTAssertFalse(WINE_RESOURCES_PATHS.contains("/lib64/wine/dxvk"))
    }

    func testAllResourcePathsAreAbsolute() {
        let nonAbsolute = WINE_RESOURCES_PATHS.filter { !$0.hasPrefix("/") }
        XCTAssertTrue(nonAbsolute.isEmpty, "Found non-absolute paths: \(nonAbsolute)")
    }
}
