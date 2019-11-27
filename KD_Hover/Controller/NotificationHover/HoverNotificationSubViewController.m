//
//  HoverNotificationSubViewController.m
//  KD_Hover
//
//  Created by paul on 2019/11/26.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverNotificationSubViewController.h"

@interface HoverNotificationSubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) KD_TableView *subTableView;
@property (nonatomic, strong) NSMutableArray *subDataArray;
@property (nonatomic, assign) BOOL canScroll;

@end

static NSInteger CellHeight = 80;

@implementation HoverNotificationSubViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.subTableView];
    [self.subTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self initSelfData];
    [self.subTableView reloadData];
    [self addNotification];
    self.canScroll = NO;
}

-(void)dealloc {
    KD_RemoveNotification(self, KD_MainTableIsStayToTop, nil);
    KD_RemoveNotification(self, KD_MainTableIsLeaveTop, nil);
}

#pragma mark - self
-(void)addNotification {
    KD_AddNotification(self, @selector(mainTableViewStayTop:), KD_MainTableIsStayToTop, nil);
    KD_AddNotification(self, @selector(mainTableViewLeaveTop:), KD_MainTableIsLeaveTop, nil);
}

-(void)mainTableViewStayTop:(NSNotification *)noti {
    self.canScroll = YES;
}

-(void)mainTableViewLeaveTop:(NSNotification *)noti {
    self.canScroll = NO;
}

-(void)initSelfData {
    for (int i = 0; i < 50; i++) {
        [self.subDataArray addObject:@""];
    }
}
#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subDataArray.count;
}

static NSString *identifier = @"SubCell";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if((indexPath.row + 1)%2 == 0) {
        cell.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.15];
        tableView.separatorColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.15];
        tableView.separatorColor = [UIColor whiteColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView.contentOffset.y:%f", scrollView.contentOffset.y);
    if(scrollView.contentOffset.y <= 0) {
        KD_PostNotification(KD_SubTableIsStayToTop, nil);
    } else {
        KD_PostNotification(KD_SubTableIsLeaveTop, nil);
    }
    if(!self.canScroll) {
        [self.subTableView setContentOffset:CGPointZero];
    }
}

#pragma mark - lazy

-(KD_TableView *)subTableView {
    if(_subTableView == nil) {
        _subTableView = [[KD_TableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _subTableView;
}

-(NSMutableArray *)subDataArray {
    if(_subDataArray == nil) {
        _subDataArray = [NSMutableArray new];
    }
    return _subDataArray;
}

@end
