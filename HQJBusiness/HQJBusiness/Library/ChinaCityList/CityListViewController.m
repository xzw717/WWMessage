//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityListViewController.h"
#import "ZYPinYinSearch.h"
#import "ButtonGroupView.h"
#import "PinYinForObjc.h"
#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor lightGrayColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define HotBtnColumns 3 //每行显示的热门城市数
#define BGCOLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
@interface CityListViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate,ButtonGroupViewDelegate>
{
    UIImageView   *_bgImageView;
    UIView        *_tipsView;
    UILabel       *_tipsLab;
    NSTimer       *_timer;
    int           _firstPosition;
}
@property (strong, nonatomic) UITextField *searchText;

@property (strong, nonatomic) NSMutableDictionary *searchResultDic;

@property (strong, nonatomic) ButtonGroupView *locatingCityGroupView;//定位城市

@property (strong, nonatomic) ButtonGroupView *hotCityGroupView;//热门城市

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) NSMutableArray *arrayCitys;   //城市数据

@property (strong, nonatomic) NSMutableDictionary *cities;

@property (strong, nonatomic) NSMutableArray *keys; //城市首字母

//@property (nonatomic,strong) AMapLocationManager * locationManager;

//@property (nonatomic,strong) LocationManager *locationM;

@property (nonatomic, assign) CGFloat headeSectionHeight;


@property (nonatomic, strong) UILabel *locatingCityLabel;
@property (nonatomic, strong) UILabel *commonlyUsedCityLabel;
@property (nonatomic, strong) UILabel *hotCityLabel;
@property (nonatomic, strong) UIView  *searchView ;
@property (nonatomic, strong) UIImageView *searchBg;

@end

@implementation CityListViewController
- (UIView *)searchView {
    if (_searchView == nil) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, 40 * (HEIGHT / 568))];
        _searchView.backgroundColor = [UIColor clearColor];
        
       
    }
    return _searchView;
}
- (UIImageView *)searchBg {
    if (_searchBg == nil) {
        _searchBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
        _searchBg.frame = CGRectMake(0, 0, WIDTH, 40 * (HEIGHT / 568));
    }
    return _searchBg;
}

- (UITextField *)searchText {
    if (_searchText == nil) {
        _searchText = [[UITextField alloc]initWithFrame:CGRectMake(30*(WIDTH/320), 0, WIDTH - 30, 40 * (HEIGHT / 568))];
        _searchText.backgroundColor = [UIColor clearColor];
        _searchText.font = [UIFont systemFontOfSize:13];
        _searchText.placeholder  = @"请输入城市名称或首字母查询";
        _searchText.returnKeyType = UIReturnKeySearch;
        _searchText.textColor    = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
        _searchText.delegate     = self;
        [_searchText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchText;
}

- (UIView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NavigationControllerHeight+ 40 * (HEIGHT / 568), WIDTH, HEIGHT - NavigationControllerHeight - 40 * (HEIGHT / 568)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        [self ininHeaderView];

    }
    return _tableView;
}

- (UILabel *)locatingCityLabel {
    if (_locatingCityLabel == nil) {
        _locatingCityLabel = [[UILabel alloc]init];
        _locatingCityLabel.text = @"定位城市";
        _locatingCityLabel.font = [UIFont systemFontOfSize:15];
    }
    return _locatingCityLabel;
}

- (UILabel *)commonlyUsedCityLabel {
    if (_commonlyUsedCityLabel == nil) {
       _commonlyUsedCityLabel = [[UILabel alloc]init];
        _commonlyUsedCityLabel.text = @"常用城市";
        _commonlyUsedCityLabel.font = [UIFont systemFontOfSize:15];
    }
    return _commonlyUsedCityLabel;
}

- (UILabel *)hotCityLabel {
    if (_hotCityLabel == nil) {
        _hotCityLabel = [[UILabel alloc]init];
        _hotCityLabel.text = @"热门城市";
        _hotCityLabel.font = [UIFont systemFontOfSize:15];

    }
    return _hotCityLabel;
}

- (ButtonGroupView *)locatingCityGroupView {
    if (_locatingCityGroupView == nil) {
        _locatingCityGroupView = [[ButtonGroupView alloc]init];
        _locatingCityGroupView.delegate = self;
        _locatingCityGroupView.columns = 3;
       
    }
    return _locatingCityGroupView;
}
- (ButtonGroupView *)hotCityGroupView {
    if (_hotCityGroupView == nil) {
        _hotCityGroupView = [[ButtonGroupView alloc]init];
        _hotCityGroupView.backgroundColor = [UIColor clearColor];
        _hotCityGroupView.delegate = self;
        _hotCityGroupView.columns = 3;
    }
    return _hotCityGroupView;
}
- (ButtonGroupView *)historicalCityGroupView {
    if (_historicalCityGroupView == nil) {
        _historicalCityGroupView = [[ButtonGroupView alloc]init];
        _historicalCityGroupView.backgroundColor = [UIColor clearColor];
        _historicalCityGroupView.delegate = self;
        _historicalCityGroupView.columns = 3;
    }
    return _historicalCityGroupView;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray array];
        
        self.arrayHistoricalCity = [NSMutableArray array];
        
//        self.arrayLocatingCity   = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
        self.headeSectionHeight = 20.0f;
    }
    return self;
}

- (BOOL)willDealloc {
    return NO;
}

- (void)dealloc {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BGCOLOR;
    
    [self getCityData];
    
    [self setNavigationWithTitle:@"选择城市"];

    

    
    //3自定义背景
    [self.view addSubview:self.searchView];
    [self.searchView addSubview:self.searchBg];
    [self.searchView addSubview:self.searchText];
    
    
    //添加单击事件 取消键盘第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    [self addHeader];
    [self layoutHeader];
    [self.view addSubview:self.tableView];



}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)resignFirstResponder:(UITapGestureRecognizer*)tap
{
    [_searchText resignFirstResponder];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
  
        return NO;
        
    }
    
    return YES;
    
}

- (void)textChange:(UITextField*)textField
{
    [self filterContentForSearchText:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)setNavigationWithTitle:(NSString *)title
{
    //自定义导航栏
    UIView *customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NavigationControllerHeight)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, customNavView.frame.size.width, customNavView.frame.size.height-20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text          = title;
    [customNavView addSubview:titleLab];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(15, 20, 40, titleLab.frame.size.height);
    @weakify(self);
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [customNavView addSubview:backBtn];
    customNavView.backgroundColor = [UIColor whiteColor];

   
    
    
    [self.view addSubview:customNavView];
}

- (void)back:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)ininHeaderView
{
    
  
  
   [RACObserve(self, arrayLocatingCity) subscribeNext:^(NSString *x) {
       if ([x isEqualToString:@"正在定位中..."]) {
           self.locatingCityGroupView.userInteractionEnabled = NO;
           self.locatingCityGroupView.buttonTitleStr = @"正在定位中...";
           
       } else if ([x isEqualToString:@"定位失败，请重试"]) {
           self.locatingCityGroupView.userInteractionEnabled = YES;
           self.locatingCityGroupView.buttonTitleStr = @"定位失败，请重试";
           
       } else {
           self.locatingCityGroupView.userInteractionEnabled = YES;
           self.locatingCityGroupView.buttonTitleStr = nil;
           [self.locatingCityGroupView layoutSubviews];
       }
      
   }];
    
    
    
//    self.locatingCityGroupView.items = @[[CityItem initWithTitleName:_arrayLocatingCity]];
 

    //常用城市

    self.historicalCityGroupView.items = [self GetCityDataSoucre:_arrayHistoricalCity];
    //热门城市
    

    self.hotCityGroupView.items = [self GetCityDataSoucre:_arrayHotCity];
    
    self.tableHeaderView.frame = CGRectMake(0, 0, WIDTH,280);
    self.tableView.tableHeaderView.frame = self.tableHeaderView.frame;
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    
}

- (void)addHeader {
//    [self.tableHeaderView addSubview:self.locatingCityLabel];
//    [self.tableHeaderView addSubview:self.locatingCityGroupView];
    [self.tableHeaderView addSubview:self.hotCityLabel];
    [self.tableHeaderView addSubview:self.historicalCityGroupView];
    [self.tableHeaderView addSubview:self.commonlyUsedCityLabel];
    [self.tableHeaderView addSubview:self.hotCityGroupView];
}
- (void)layoutHeader {
    
//    [self.locatingCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake(160, 21));
//    }];
    
//    [self.locatingCityGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.locatingCityLabel.bottom).offset(10);
//        make.left.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(WIDTH, 45));
//    }];
    
    
    [self.commonlyUsedCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(160, 21));
    }];
    
    [self.historicalCityGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.commonlyUsedCityLabel.mas_bottom).offset(10);
        long rowHistorical = _arrayHistoricalCity.count/3;
        if (_arrayHistoricalCity.count%3 > 0) {
            rowHistorical += 1;
        }
        CGFloat hisViewHight = 45*rowHistorical;
        
        make.size.mas_equalTo(CGSizeMake(WIDTH, hisViewHight));
    }];
    
    [self.hotCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.historicalCityGroupView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(160, 21));
    }];
    
    [self.hotCityGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.hotCityLabel.mas_bottom).offset(10);
        long row = _arrayHotCity.count/3;
        if (_arrayHotCity.count%3 > 0) {
            row += 1;
        }
        CGFloat hotViewHight = 45 * row;
        make.size.mas_equalTo(CGSizeMake(WIDTH, hotViewHight));
    }];
   
}
- (void)updateCity {
    HQJLog(@"--3--%@",self.arrayLocatingCity);

   
}

- (NSArray*)GetCityDataSoucre:(NSArray*)ary
{
    NSMutableArray *cityAry = [[NSMutableArray alloc]init];
    for (NSString*cityName in ary) {
        [cityAry addObject: [CityItem initWithTitleName:cityName]];
    }
    
    return cityAry;
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
//    //添加热门城市
//    NSString *strHot = @"#";
//    [self.keys insertObject:strHot atIndex:0];
//    [self.cities setObject:_arrayHotCity forKey:strHot];
    
    NSArray *allValuesAry = [self.cities allValues];
    for (NSArray*oneAry in allValuesAry) {
        
        for (NSString *cityName in oneAry) {
           [_arrayCitys addObject:cityName];
        }
    }
    
    
    

}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headeSectionHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.headeSectionHeight != 20.0f) {
        return nil;
    } else {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
        bgView.backgroundColor = BGCOLOR;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 19, bgView.frame.size.width, 1)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        
        
        NSString *key = [_keys objectAtIndex:section];
        
        titleLabel.text = key;
        [bgView addSubview:line];
        
        [bgView addSubview:titleLabel];
        
        return bgView;

    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *indexNumber = [NSMutableArray arrayWithArray:_keys];
//    NSString *strHot = @"#";
//    //添加搜索前的#号
//    [indexNumber insertObject:strHot atIndex:0];
    return indexNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    NSLog(@"title = %@",title);
    [self showTipsWithTitle:title];
    
    return index;
}

- (void)showTipsWithTitle:(NSString*)title
{
    
    //获取当前屏幕window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //添加黑色透明背景
//    if (!_bgImageView) {
//        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
//        _bgImageView.backgroundColor = [UIColor blackColor];
//        _bgImageView.alpha = 0.1;
//        [window addSubview:_bgImageView];
//    }
    if (!_tipsView) {
        //添加字母提示框
        _tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tipsView.center = window.center;
        _tipsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
        //设置提示框圆角
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.cornerRadius  = _tipsView.frame.size.width/20;
        _tipsView.layer.borderColor   = [UIColor whiteColor].CGColor;
        _tipsView.layer.borderWidth   = 2;
        [window addSubview:_tipsView];
    }
    if (!_tipsLab) {
        //添加提示字母lable
        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tipsView.frame.size.width, _tipsView.frame.size.height)];
        //设置背景为透明
        _tipsLab.backgroundColor = [UIColor clearColor];
        _tipsLab.font = [UIFont boldSystemFontOfSize:50];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        
        [_tipsView addSubview:_tipsLab];
    }
   _tipsLab.text = title;//设置当前显示字母
    
//    [self performSelector:@selector(hiddenTipsView:) withObject:nil afterDelay:0.3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hiddenTipsView];
//    });
    
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(hiddenTipsView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)hiddenTipsView
{
    
    [UIView animateWithDuration:0.2 animations:^{
        _bgImageView.alpha = 0;
        _tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [_tipsView removeFromSuperview];
         _bgImageView = nil;
         _tipsLab     = nil;
         _tipsView    = nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *cityName = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    if (_delegate) {
        [_delegate didClickedWithCityName:cityName];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item
{
    if (buttonGroupView == _locatingCityGroupView) {
        if ([_arrayLocatingCity isEqualToString:@"定位失败，请重试"]) {
        } else {
            if (_delegate) {
                
                [_delegate didClickedWithCityName:item.cityItem.titleName];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        if (_delegate) {
            
            [_delegate didClickedWithCityName:item.cityItem.titleName];
        }
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    
  
        
    
}




NSInteger cityNameSort(id str1, id str2, void *context)
{
    NSString *string1 = (NSString*)str1;
    NSString *string2 = (NSString*)str2;
    
    return  [string1 localizedCompare:string2];
}
/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
    if (searchText.length > 0) {
        _searchResultDic = nil;
        _searchResultDic = [[NSMutableDictionary alloc]init];
        
        //搜索数组中是否含有关键字
        NSArray *resultAry  = [ZYPinYinSearch searchWithOriginalArray:_arrayCitys andSearchText:searchText andSearchByPropertyName:@""];
        //     NSLog(@"搜索结果:%@",resultAry) ;
        
        for (NSString*city in resultAry) {
            //获取字符串拼音首字母并转为大写
            NSString *pinYinHead = [PinYinForObjc chineseConvertToPinYinHead:city].uppercaseString;
            NSString *firstHeadPinYin = [pinYinHead substringToIndex:1]; //拿到字符串第一个字的首字母
            //        NSLog(@"pinYin = %@",firstHeadPinYin);
            
            
            NSMutableArray *cityAry = [NSMutableArray arrayWithArray:[_searchResultDic objectForKey:firstHeadPinYin]]; //取出首字母数组
            
            if (cityAry != nil) {
                
                [cityAry addObject:city];
                
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
                
            }else
            {
                cityAry= [[NSMutableArray alloc]init];
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }
            
            
            
        }
        //    NSLog(@"dic = %@",dic);

        if (resultAry.count > 0 ) {
            
            _cities = nil;
            _cities = _searchResultDic;
            [_keys removeAllObjects];
            //按字母升序排列
            [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]] ;
            _tableView.tableHeaderView = nil;
            self.headeSectionHeight = 0.01f;
            [_tableView reloadData];
        }

    }else
    {
        //当字符串清空时 回到初始状态
        _cities = nil;
         [_keys removeAllObjects];
        [_arrayCitys removeAllObjects];
        [self getCityData];
        _tableView.tableHeaderView = _tableHeaderView;
        self.headeSectionHeight = 20.0f;
        [_tableView reloadData];
    }
    
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
