//
//  HoverContentInsetsSubViewController.m
//  KD_Hover
//
//  Created by paul on 2019/11/27.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverContentInsetsSubViewController.h"

@interface HoverContentInsetsSubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *subDataArray;

@end

static NSInteger CellHeight = 80;

@implementation HoverContentInsetsSubViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.subTableView];
    [self.subTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self initSelfData];
    [self.subTableView reloadData];
    self.canScroll = NO;
}

#pragma mark - self
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
