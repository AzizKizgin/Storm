//
//  DummyMessage.swift
//  Storm
//
//  Created by Aziz Kızgın on 23.07.2024.
//

import Foundation

let dummyMessage1 = Message(id: 1, sender: dummyUserResponse,chatId: "1", content: lorem, createdAt: "2024-07-26T01:31:58.815646", media: [], readBy: ["userId","userId2"], reactions: [])

let dummyMessage2 = Message(id: 2, sender: dummyUserResponse2,chatId: "1", content: "asdasfdsfsdf", createdAt: "2024-07-25T14:21:03.241907+03:00", media: [], readBy: ["userId2"], reactions: [])

let dummyMessage3 = Message(id: 3, sender: dummyUserResponse3,chatId: "2", content: "It is a message", createdAt: "2024-07-24T14:21:03.241907+03:00", media: [], readBy: ["userId3"], reactions: [])

let dummyMessage4 = Message(id: 4, sender: dummyUserResponse,chatId: "2", content: "Ok!", createdAt: "2024-07-26T01:31:58.815646", media: [], readBy: ["userId","userId3"], reactions: [])

private let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur diam nec libero feugiat, a mattis libero lobortis. Proin varius sodales commodo. Ut pharetra molestie justo vel bibendum. Maecenas a enim vel metus molestie placerat. Pellentesque convallis imperdiet nisi vitae volutpat. Fusce odio nisi, pharetra a rhoncus eget, volutpat eu enim. Morbi cursus at felis vitae venenatis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ornare felis et euismod elementum. Etiam sed neque ante. Quisque vel sem ex.

Nunc ultrices justo pulvinar odio euismod, in gravida nisl commodo. Sed aliquet elementum aliquet. Etiam vel tellus neque. Duis nisl ipsum, maximus a justo ut, efficitur ultrices sem. Ut imperdiet quam in diam semper posuere. Nam at nulla augue. Vivamus finibus mollis fermentum. Etiam odio lectus, convallis sed porttitor nec, ultricies eget sapien. Integer ut consequat massa. Nullam in diam pulvinar, facilisis leo vitae, feugiat orci. Aliquam egestas egestas sem nec sollicitudin. Praesent tristique euismod diam in porttitor. In dignissim, tellus a faucibus lobortis, dolor neque eleifend odio, non accumsan ipsum dui in nulla. Nam mattis facilisis interdum.
"""
