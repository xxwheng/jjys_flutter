//
//  XXJJAboutJiaJiaYueSaoViewController.m
//  JJYSPlusPlus
//
//  Created by Wangguibin on 16/7/16.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "XXJJAboutJiaJiaYueSaoViewController.h"
#import <StoreKit/StoreKit.h>
#import "XXYSLogoAndVersionView.h"

@interface XXJJAboutJiaJiaYueSaoViewController ()<UITableViewDelegate,UITableViewDataSource,SKStoreProductViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation XXJJAboutJiaJiaYueSaoViewController

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,    NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
		adjustsScrollViewInsets_NO(_tableView, self);
//		_tableView.height -= BottomHeight;
        _tableView.backgroundColor  = RGB(239, 240, 241);
        _tableView.dataSource =self;
        _tableView.delegate = self;
        _tableView.rowHeight = 48.0f ;
    }
    return _tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];

    [self setupBasicSettingsWithNavBarTitle:@"关于家家月嫂"];
    [self setupNavBarPopButton];
    [self setupUI];
    [self initData];
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarHidden  = NO;
}

- (void)backToLastController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setupUI{
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView =[[UIView alloc]init];
    //展示logo的视图
    XXYSLogoAndVersionView *logoView =[XXYSLogoAndVersionView FromXIB];
    logoView.frame =CGRectMake(0, 0, KWIDTH , 200);
    logoView.backgroundColor = self.tableView.backgroundColor;

    logoView.versionNumberLabel.text =[NSString stringWithFormat:@"家家月嫂%@", kAPPVersion];
    self.tableView.tableHeaderView = logoView;
}


- (void)initData{
    NSArray* dataArray = @[
        @{
            @"image" : @"about",
            @"title" : @"关于家家"
        },
    ];

    [self.dataSource addObjectsFromArray: dataArray];
    [self.tableView reloadData];
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static  NSString * cellID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator ;
    }
    cell.textLabel.text =self.dataSource[indexPath.row][@"title"];
	NSString *imageName =self.dataSource[indexPath.row][@"image"];
    cell.imageView.image = [UIImage imageNamed: imageName];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	switch (indexPath.row) {
		case 0:{
				//关于家家
			[self skipWebViewVCWithURL: JJAboutUsUrl  tittle:@"关于家家"];
		}break;
    }
}


- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark- 前往AppStore
- (void)gotoAppstore{
    SKStoreProductViewController *appStoreVC =[[SKStoreProductViewController alloc]init];
    appStoreVC.delegate = self;
    [appStoreVC loadProductWithParameters:@{ SKStoreProductParameterITunesItemIdentifier : KJJYSAPPID } completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
			[[UINavigationBar appearance] setTintColor: [UIColor blueColor]];
			[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
			[[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
			[[UINavigationBar appearance] setBarTintColor: [UIColor whiteColor]];
            [self presentViewController: appStoreVC animated:YES completion:nil];
        }
    }];
}

#pragma mark - 取消按钮监听
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
	[[UINavigationBar appearance] setTintColor: KWhiteColor];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: KWhiteColor}];
	[[UINavigationBar appearance] setBackgroundColor: KNavColor];
	[[UINavigationBar appearance] setBarTintColor: KNavColor];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
