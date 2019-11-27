//
//  HoverRootViewController.m
//  KD_Hover
//
//  Created by paul on 2019/11/25.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverRootViewController.h"
#import "HoverNotificationSubViewController.h"
#import "HoverNotificationTableViewController.h"
#import "HoverNotificationScrollViewController.h"
#import "HoverObserverTableViewController.h"
#import "HoverObserverScrollViewController.h"

@interface HoverRootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) KD_TableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *mainDataArray;

@end

@implementation HoverRootViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOVER(悬停)";
    [self initSelfData];
    [self.mainTableView reloadData];
}

#pragma mark - self

-(void)initSelfData {
    [self.mainDataArray addObject:@"TableView Notification Hover"];
    [self.mainDataArray addObject:@"ScrollView Notification Hover"];
    [self.mainDataArray addObject:@"TableView Observer Hover"];
    [self.mainDataArray addObject:@"ScrollView Observer Hover"];
}

#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainDataArray.count;
}

static NSString *identifier = @"cell";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if(self.mainDataArray.count > indexPath.row) {
        cell.textLabel.text = self.mainDataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        HoverNotificationTableViewController *vc = [[HoverNotificationTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 1) {
        HoverNotificationScrollViewController *vc = [[HoverNotificationScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 2) {
        HoverObserverTableViewController *vc = [[HoverObserverTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 3) {
        HoverObserverScrollViewController *vc = [[HoverObserverScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.estimatedRowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView.estimatedSectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableView.estimatedSectionFooterHeight;
}

#pragma mark - lazy
-(KD_TableView *)mainTableView {
    if(_mainTableView == nil) {
        _mainTableView = [[KD_TableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _mainTableView;
}

-(NSMutableArray *)mainDataArray {
    if(_mainDataArray == nil) {
        _mainDataArray = [NSMutableArray new];
    }
    return _mainDataArray;
}

@end
