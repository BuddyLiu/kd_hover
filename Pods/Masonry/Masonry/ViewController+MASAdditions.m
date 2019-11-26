//
//  UIViewController+MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+MASAdditions.h"

#ifdef MAS_VIEW_CONTROLLER

@implementation MAS_VIEW_CONTROLLER (MASAdditions)

- (MASViewAttribute *)mas_topLayoutGuide {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}
- (MASViewAttribute *)mas_topLayoutGuideTop {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}
- (MASViewAttribute *)mas_topLayoutGuideBottom {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}

- (MASViewAttribute *)mas_bottomLayoutGuide {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}
- (MASViewAttribute *)mas_bottomLayoutGuideTop {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}
- (MASViewAttribute *)mas_bottomLayoutGuideBottom {
    if (@available(iOS 7.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    } else {
        // Fallback on earlier versions
        return [MASViewAttribute new];
    }
}



@end

#endif
