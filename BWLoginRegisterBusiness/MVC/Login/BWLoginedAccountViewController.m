//
//  BWLoginedAccountViewController.m
//  BWLoginRegisterBusiness
//
//  Created by Bob Wong on 16/7/11.
//  Copyright © 2016年 Bob Wong Studio. All rights reserved.
//

#import "BWLoginedAccountViewController.h"

@interface BWLoginedAccountViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayDataSource;  //!< Data Source Array

@end

@implementation BWLoginedAccountViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select Logined Account";
    
    _arrayDataSource = [NSMutableArray arrayWithArray:[BWUserCacheManager getCacheAccounts]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - System Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayDataSource ? _arrayDataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _arrayDataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockSelectedAccount) {
        self.blockSelectedAccount(_arrayDataSource[indexPath.row]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [BWUserCacheManager deleteCacehWithUserAccount:self.arrayDataSource[indexPath.row]];
        [self.arrayDataSource removeObjectAtIndex:indexPath.row];  // 移除TableView数据源的数据
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];  // 移除tableView中的数据
    }
}

@end
