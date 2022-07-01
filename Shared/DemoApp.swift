import SwiftUI
import SwiftUIBackports

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                Backport.Section("Backports") {
                    AsyncImageDemo()
                    AppStorageDemo()
                    LabelDemo()
                    NavigationDemo()
                    ProgressDemo()
                    RefreshableDemo()
                    StateObjectDemo()
                }

#if os(iOS)
                if #available(iOS 14, *) {
                    Backport.Section("Backports (iOS 14+)") {
                        PresentationDemo()
                        ScaledMetricDemo()
                    }
                }
#endif

                Backport.Section("Extras") {
                    FittingGeometryReaderDemo()
                    FittingScrollViewDemo()
                }
            }
            .backport.navigationTitle("Demos")
        }
        #if os(macOS)
        .frame(maxWidth: 800, maxHeight: 800)
        #endif
    }
}

#if os(iOS)
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { true }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

final class SceneDelegate: UIResponder, UISceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)

#warning("Switch back to RootView")
        if #available(iOS 14, *) {
            window?.rootViewController = UIHostingController(rootView: HostingDemo())
        }

//        window?.rootViewController = UIHostingController(rootView: RootView())
        window?.makeKeyAndVisible()
    }
}
#else
@available(macOS 11, *)
@main struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
#endif
