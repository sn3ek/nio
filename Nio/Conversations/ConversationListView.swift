import SwiftUI
import SwiftMatrixSDK

struct ConversationListContainerView: View {
    @EnvironmentObject var store: MatrixStore<AppState, AppAction>

    @State private var selectedNavigationItem: SelectedNavigationItem?

    var body: some View {
        ConversationListView(selectedNavigationItem: $selectedNavigationItem,
                             conversations: store.state.recentRooms ?? [])
            .sheet(item: $selectedNavigationItem, content: { NavigationSheet(selectedItem: $0) })
            .onAppear {
                self.store.send(AppAction.recentRooms)
            }
    }
}

struct ConversationListView: View {
    @Binding fileprivate var selectedNavigationItem: SelectedNavigationItem?

    var conversations: [MXRoom]

    var settingsButton: some View {
        Button(action: {
            self.selectedNavigationItem = .settings
        }, label: {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 25))
        })
    }

    var newConversationButton: some View {
        Button(action: {
            self.selectedNavigationItem = .newMessage
        }, label: {
            Image(systemName: "plus")
                .font(.system(size: 25))
        })
    }

    var body: some View {
        NavigationView {
            List(conversations) { conversation in
                NavigationLink(destination: ConversationContainerView(conversation: conversation)) {
                    ConversationListCellContainerView(conversation: conversation)
                }
            }
            .navigationBarTitle("Nio", displayMode: .inline)
            .navigationBarItems(leading: settingsButton, trailing: newConversationButton)
        }
    }
}

private enum SelectedNavigationItem: Int, Identifiable {
    case settings
    case newMessage

    var id: Int {
        return self.rawValue
    }
}

private struct NavigationSheet: View {
    var selectedItem: SelectedNavigationItem

    var body: some View {
        switch selectedItem {
        case .settings:
            return Text("Settings")
        case .newMessage:
            return Text("New Message")
        }
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView(selectedNavigationItem: .constant(nil), conversations: [])
    }
}
