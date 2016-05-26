//
//  ViewController.m
//  FSTableViewPlaceholder
//
//  Created by 巩柯 on 16/5/16.
//  Copyright © 2016年 GIKI. All rights reserved.
//

#import "ViewController.h"
#import "FSEmptyTableView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loaddata{
    [self.tableView fs_emptyReloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor blackColor];
//    UILabel *la = [[UILabel alloc]init];
//    la.text = @"sakdjflsj";
//    la.frame = CGRectMake(0, 0, 40, 44);
//    [cell.contentView addSubview:la];
    cell.textLabel.text = @"ceshi ";
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (UIView *)fs_getEmptyView{

    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UILabel * lab = [[UILabel alloc]init];
    lab.text = @"这是一个空页面";
    lab.backgroundColor = [UIColor redColor];
    lab.frame = CGRectMake(100, 100, 150, 100);
    [view addSubview:lab];
    return view;
}

- (BOOL)fs_emptyViewEnableScoll{
    return YES;
}

@end
