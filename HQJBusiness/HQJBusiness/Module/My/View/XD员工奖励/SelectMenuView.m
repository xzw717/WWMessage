//
//  SelectMenuView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectMenuView.h"
@interface SelectMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSArray *titleArray;
@end
@implementation SelectMenuView

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.f];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 5.0;
        self.layer.cornerRadius = 9.0;
        self.clipsToBounds = NO;
        [self setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [self addView:view];
       
    }
    return self;
}
+ (instancetype)showMenuWithView:(UIView *)view {
    return [[self alloc]initWithView:view];
}

- (void)drawRect:(CGRect)rect {
    CGRect rects =   CGRectMake(self.menuTableView.frame.origin.x + 6, self.menuTableView.frame.origin.y - 6,10 , 3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, rects.origin.x + rects.size.width /2, rects.origin.y);
    CGContextAddLineToPoint(context,rects.origin.x, self.menuTableView.frame.origin.y);
    CGContextAddLineToPoint(context,rects.origin.x + rects.size.width, self.menuTableView.frame.origin.y);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill]; //设置填充色
    [[UIColor whiteColor] setStroke];//边框也设置为_color，否则为默认的黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}
- (void)addView:(UIView *)view {
    UIWindow *menuWindow = [UIApplication sharedApplication].delegate.window;
    [menuWindow addSubview:self];
       [self addSubview:self.menuTableView];
    CGRect rect=[view convertRect: view.bounds toView:menuWindow];
    [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y +rect.size.height + NewProportion(30), rect.size.width, 0)];
    [UIView animateWithDuration:0.25 animations:^{
        [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y + rect.size.height +NewProportion(30), rect.size.width, NewProportion(330))];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            [self.menuTableView setFrame:CGRectMake(rect.origin.x , rect.origin.y + rect.size.height + NewProportion(30), rect.size.width, NewProportion(320))];
        }];
    }];
   

}

- (void)removeView {
    [UIView animateWithDuration:0.15 animations:^{
          [self.menuTableView setFrame:CGRectMake(self.menuTableView.frame.origin.x , self.menuTableView.frame.origin.y, self.menuTableView.frame.size.width, NewProportion(330))];
      } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.25 animations:^{
              [self.menuTableView setFrame:CGRectMake(self.menuTableView.frame.origin.x , self.menuTableView.frame.origin.y, self.menuTableView.frame.size.width, 0)];
          } completion:^(BOOL finished) {
              [self removeFromSuperview];
          }];
          
      }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
  
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.clickTitle?:self.clickTitle(self.titleArray[indexPath.row]);
    [self removeView];
    
}
- (MenuArrayBlock)munuAry {
    if (!_munuAry) {
        __weak typeof(self) weakSelf = self;
         return ^(NSArray *titArray){
             weakSelf.titleArray = titArray;
             return weakSelf;
         };
    }
    return _munuAry;
}

- (MenuViewSelf)showView {
    if (!_showView) {
        __weak typeof(self) weakSelf = self;
        return ^(void){
            return weakSelf;
        };
    }
    return _showView;
}

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc]init];
        _menuTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.rowHeight = NewProportion(73);
        [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _menuTableView.tableFooterView = [UIView new];
        _menuTableView.layer.cornerRadius = 2; //设置imageView的圆角
        _menuTableView.layer.masksToBounds = YES;
        _menuTableView.backgroundColor = [UIColor whiteColor];

    }
    return _menuTableView;
}

@end
