//
//  HoverRootViewController.m
//  KD_Hover
//
//  Created by paul on 2019/11/25.
//  Copyright © 2019 paul. All rights reserved.
//

#import "HoverRootViewController.h"
#import "HoverSubViewController.h"
#import "HoverRootTableViewController.h"
#import "HoverRootScrollViewController.h"
#import "HoverObserverTableViewController.h"

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
    [self.mainDataArray addObject:@"TableView Hover"];
    [self.mainDataArray addObject:@"ScrollView Hover"];
    [self.mainDataArray addObject:@"TableView Observer Hover"];
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
        HoverRootTableViewController *vc = [[HoverRootTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 1) {
        HoverRootScrollViewController *vc = [[HoverRootScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.row == 2) {
        HoverObserverTableViewController *vc = [[HoverObserverTableViewController alloc] init];
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
