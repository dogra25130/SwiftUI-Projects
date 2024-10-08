//
//  Created by Timothy Moose on 1/6/24.
//

import SwiftUI

@MainActor
class HeaderModel<Tab>: ObservableObject where Tab: Hashable {

    // MARK: - API

    struct State: Equatable {
        var headerContext: HeaderContext<Tab>

        /// The height reported by the geometry reader. Includes the additional safe area padding we apply.
        var height: CGFloat = 0

        var tabsRegistered: Bool = false

        /// The height factoring in the additional safe area padding we apply.
        var safeHeight: CGFloat {
            height - headerContext.minTotalHeight
        }
    }

    @Published fileprivate(set) var state: State

    init(selectedTab: Tab, isHeaderStrechy: Bool) {
        _state = Published(
            wrappedValue: State(headerContext: HeaderContext(selectedTab: selectedTab, isHeaderStrechy: isHeaderStrechy))
        )
    }

    func sizeChanged(_ size: CGSize) {
        state.height = size.height
        state.headerContext.width = size.width
    }

    func titleHeightChanged(_ height: CGFloat) {
        state.headerContext.titleHeight = height
    }

    func minTitleHeightChanged(_ metric: MinTitleHeightPreferenceKey.Metric) {
        state.headerContext.minTitleMetric = metric
    }

    func tabBarHeightChanged(_ height: CGFloat) {
        state.headerContext.tabBarHeight = height
    }

    func selected(tab: Tab) {
        self.state.headerContext.selectedTab = tab
    }

    func safeAreaChanged(_ safeArea: EdgeInsets) {
        self.state.headerContext.safeArea = safeArea
    }

    func animationNamespaceChanged(_ animationNamespace: Namespace.ID) {
        state.headerContext.animationNamespace = animationNamespace
    }

    func tabsRegistered() {
        Task {
            guard !state.tabsRegistered else { return }
            state.tabsRegistered = true
        }
    }

    // MARK: - Constants

    // MARK: - Variables

    // MARK: - Height

    

    // MARK: - Scroll tracking

    func scrolled(tab: Tab, offset: CGFloat, deltaOffset: CGFloat) {
        guard tab == state.headerContext.selectedTab else { return }
        //print("tab=\(tab), offset=\(offset), deltaOffset=\(deltaOffset)")
        // Any time the offset is less than the max offset, the header offset exactly tracks the offset.
        if offset < state.headerContext.maxOffset {
            state.headerContext.offset = offset
        }
        // However, for greater offsets, the header offset only gets adjusted for positive changes in the offset.
        // Once we scroll too far, the header offset hits the limit, so we can't just track the offset. Instead, we
        // use the change in offset.
        else if deltaOffset > 0 {
            let unconstrainedOffset = state.headerContext.offset + deltaOffset
            state.headerContext.offset = min(unconstrainedOffset, state.headerContext.maxOffset)
        }
    }
}
