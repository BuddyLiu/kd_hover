//
//  HoverObserverScrollViewController.m
//  KD_Hover
//
//  Created by paul on 2019/11/27.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverObserverScrollViewController.h"
#import "HoverObserverSubViewController.h"

@interface HoverObserverScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) KD_ScrollView *mainScrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HoverObserverSubViewController *subTableViewController;

@property (nonatomic, assign) BOOL canScroll;

@end

static NSInteger HeaderHeight = 150;
static NSInteger HeaderSubViewCount = 3;

@implementation HoverObserverScrollViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainView];
    self.canScroll = YES;
    KD_AddObserver(self.subTableViewController.subTableView, self, @"contentOffset");
}

-(void)dealloc {
    KD_RemoveObserver(self.subTableViewController.subTableView, self, @"contentOffset");
}

#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGFloat contentOffsetY = self.subTableViewController.subTableView.contentOffset.y;
    if(contentOffsetY <= 0) {
        self.canScroll = YES;
    } else {
        self.canScroll = NO;
    }
}

#pragma mark - self
-(void)initMainView {
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(KD_StatusBarHeight + KD_NavHeight, 0, 0, 0));
    }];
    
    [self.view layoutIfNeeded];
    self.mainScrollView.contentSize = CGSizeMake(KD_ScreenSize.width, KD_ScreenSize.height - KD_StatusBarHeight - KD_NavHeight + HeaderHeight*HeaderSubViewCount);
    
    [self.mainScrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.mainScrollView);
        make.width.equalTo(@(self.mainScrollView.frame.size.width));
        make.height.equalTo(@(HeaderHeight*HeaderSubViewCount));
    }];
    
    [self.view layoutIfNeeded];
    UIView *lastView = nil;
    for (int i = 0; i < HeaderSubViewCount; i++) {
        UIView *subView = [[UIView alloc] init];
        if(i == 0) {
            subView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.15];
        } else if(i == 1) {
            subView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        } else {
            subView.backgroundColor = [UIColor whiteColor];
        }
        [self.headerView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView) {
                make.top.equalTo(lastView.mas_bottom);
            } else {
                make.top.equalTo(self.headerView);
            }
            make.left.right.equalTo(self.headerView);
            make.height.equalTo(@(HeaderHeight));
        }];
        lastView = subView;
    }
    
    [self.mainScrollView addSubview:self.subTableViewController.view];
    [self.subTableViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.equalTo(self.mainScrollView);
        make.width.equalTo(@(self.mainScrollView.frame.size.width));
        make.height.equalTo(@(KD_ScreenSize.height - HeaderHeight - KD_StatusBarHeight - KD_NavHeight));
        make.bottom.equalTo(self.mainScrollView.mas_bottom);
    }];
}

#pragma mark - delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y < HeaderHeight*(HeaderSubViewCount-1)) {
        self.subTableViewController.canScroll = NO;
    } else {
        self.subTableViewController.canScroll = YES;
    }
    if(!self.canScroll) {
        [self.mainScrollView setContentOffset:CGPointMake(0, HeaderHeight*(HeaderSubViewCount-1))];
    }
}

#pragma mark - lazy
-(KD_ScrollView *)mainScrollView {
    if(_mainScrollView == nil) {
        _mainScrollView = [[KD_ScrollView alloc] initWithFrame:CGRectZero];
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

-(UIView *)headerView {
    if(_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

-(HoverObserverSubViewController *)subTableViewController {
    if(_subTableViewController == nil) {
        _subTableViewController = [[HoverObserverSubViewController alloc] init];
    }
    return _subTableViewController;
}

@end
