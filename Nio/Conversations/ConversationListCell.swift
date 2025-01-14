import SwiftUI
import SwiftMatrixSDK

struct ConversationListCellContainerView: View {

    var conversation: MXRoom

    var body: some View {
        let lastMessage = conversation
            .enumeratorForStoredMessagesWithType(in: [kMXEventTypeStringRoomMessage])?
            .nextEvent?
            .content["body"] as? String ?? ""
        let lastActivity = Formatter.string(forRelativeDate: conversation.summary.lastMessageDate)
        return ConversationListCell(title: conversation.summary.displayname ?? "",
                                    subtitle: lastMessage,
                                    rightDetail: lastActivity,
                                    badge: conversation.summary.localUnreadEventCount)
    }
}

struct ConversationListCell: View {
    var title: String
    var subtitle: String
    var rightDetail: String
    var badge: UInt

    var image: some View {
        ZStack {
            Circle()
                .foregroundColor(.random)
            Text(title.prefix(2).uppercased())
                .font(.headline)
                .foregroundColor(.random)
        }
        .frame(width: 40, height: 40)

    }

    var body: some View {
        HStack(alignment: .center) {
            image

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                        .allowsTightening(true)
                    Spacer()
                    Text(rightDetail)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .allowsTightening(true)
                    if badge != 0 {
                        Spacer()
                        ZStack {
                            Circle()
                                .foregroundColor(.accentColor)
                                .frame(width: 20, height: 20)
                            Text(String(badge))
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

//swiftlint:disable line_length
struct ConversationListCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConversationListCell(title: "Morpheus",
                                 subtitle: "Red or blue 💊?",
                                 rightDetail: "10 minutes ago",
                                 badge: 2)
            ConversationListCell(title: "Morpheus",
                                 subtitle: "Red or blue 💊?",
                                 rightDetail: "10 minutes ago",
                                 badge: 0)
            ConversationListCell(title: "Morpheus",
                                 subtitle: "Nesciunt quaerat voluptatem enim sunt. Provident id consequatur tempora nostrum. Sit in voluptatem consequuntur at et provident est facilis. Ut sit ad sit quam commodi qui.",
                                 rightDetail: "12:29",
                                 badge: 0)
            ConversationListCell(title: "Morpheus",
                                 subtitle: "Nesciunt quaerat voluptatem enim sunt. Provident id consequatur tempora nostrum. Sit in voluptatem consequuntur at et provident est facilis. Ut sit ad sit quam commodi qui.",
                                 rightDetail: "12:29",
                                 badge: 1)
        }
//        .padding()
        .accentColor(.purple)
        .previewLayout(.sizeThatFits)
    }
}
