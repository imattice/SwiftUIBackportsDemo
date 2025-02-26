import SwiftUI
import SwiftUIBackports

struct FittingGeometryReaderDemo: View {
    var body: some View {
        NavigationLink {
            DemoView()
        } label: {
            Text("FittingGeometryReader")
        }
    }
}

private struct DemoView: View {

    @State private var showFitting: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 0)

            if showFitting {
                FittingGeometryReader { geo in
                    content
                }
            } else {
                GeometryReader { _ in
                    content
                }
            }

            Spacer(minLength: 0)

            Button {
                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.4)) {
                    showFitting.toggle()
                }
            } label: {
                Text(showFitting ? "Show Geometry Reader" : "Show Fitting Geometry Reader")
            }
        }
        .padding()
        .backport.navigationTitle("FittingGeometryReader")
    }

    var content: some View {
        ZStack {
            Rectangle()
                #if os(macOS)
                .foregroundColor(Color(.windowBackgroundColor))
                #else
                .foregroundColor(Color(.separator))
                #endif
                .clipShape(RoundedRectangle(cornerRadius: 13))

            Rectangle()
                .foregroundColor(.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 13))
                .frame(width: 200)
        }
    }

}
