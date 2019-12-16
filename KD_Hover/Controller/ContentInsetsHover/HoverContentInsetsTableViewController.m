//
//  HoverContentInsetsTableViewController.m
//  KD_Hover
//
//  Created by dzj on 2019/11/28.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverContentInsetsTableViewController.h"

@interface HoverContentInsetsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) KD_TableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *headerView;

@end

static NSInteger HeaderHeight = 150;
static NSInteger MainTableViewTag = 9001;

@implementation HoverContentInsetsTableViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    for (int i = 0; i < 50; i++) {
        [self.dataArray addObject:@""];
    }
    [self.mainTableView reloadData];
    self.mainTableView.contentInset = UIEdgeInsetsMake(HeaderHeight*3, 0, 0, 0);
    self.mainTableView.contentOffset = CGPointMake(0, -HeaderHeight*3);
    [self initMainView];
}

#pragma mark - self

-(void)initMainView {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(KD_StatusBarHeight+KD_NavHeight);
        make.height.mas_equalTo(HeaderHeight*3);
    }];
    UIView *lastView = nil;
    for (int i = 0; i < 3; i++) {
        UIView *subView = [[UIView alloc] init];
        subView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:(i+1)/5.0];
        [self.headerView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headerView);
            make.height.mas_equalTo(HeaderHeight);
            if(lastView == nil) {
                make.top.equalTo(self.headerView);
            } else {
                make.top.equalTo(lastView.mas_bottom);
            }
        }];
        lastView = subView;
    }
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

static NSString *identifier = @"cell";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if((indexPath.row + 1)%2 == 0) {
        cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.15];
        tableView.separatorColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
        tableView.separatorColor = [[UIColor redColor] colorWithAlphaComponent:0.15];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    NSLog(@"contentOffsetY:%f, scrollView.contentOffset.y:%f", contentOffsetY, scrollView.contentOffset.y);
    if(contentOffsetY > -(KD_StatusBarHeight + KD_NavHeight) && contentOffsetY < HeaderHeight+(KD_StatusBarHeight + KD_NavHeight)) {
        if(self.headerView.superview == nil) {
            return;
        }
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(-(contentOffsetY - (KD_StatusBarHeight + KD_NavHeight)));
            make.height.mas_equalTo(HeaderHeight*3);
        }];
    }
}

#pragma mark - lazy
-(KD_TableView *)mainTableView {
    if(_mainTableView == nil) {
        _mainTableView = [[KD_TableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tag = MainTableViewTag;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _mainTableView;
}

-(NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(UIView *)headerView {
    if(_headerView == nil) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

@end
