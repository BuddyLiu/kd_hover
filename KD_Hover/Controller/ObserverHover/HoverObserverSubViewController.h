//
//  HoverObserverSubViewController.h
//  KD_Hover
//
//  Created by dzj on 2019/11/26.
//  Copyright © 2019 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoverObserverSubViewController : UIViewController

@property (nonatomic, strong) KD_TableView *subTableView;
@property (nonatomic, assign) BOOL canScroll;

@end

NS_ASSUME_NONNULL_END
