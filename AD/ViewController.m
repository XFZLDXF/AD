//
//  ViewController.m
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import "ViewController.h"
#import "CHDraggableView+Avatar.h"
@interface ViewController ()
@property (nonatomic, retain) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    Arr=[[NSArray alloc]initWithObjects:
                  @"http://code4app.com/img/code4app_logo.png",
                  @"http://ui4app.com/img/ui4app_logo.png",
                  @"http://www.baidu.com/img/baidu_sylogo1.gif",nil];
    self.array = @[@"ktv",@"spa",@"健身",@"咖啡",@"推拿",@"棋牌",@"游泳",@"网吧",@"茶艺",@"足疗",@"马术",@"高尔夫"];
    [self AdImg:Arr];
    [self setCurrentPage:page.currentPage];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CHDraggableView *avatar = [CHDraggableView viewWithImage:[UIImage imageNamed:@"1"]];
    [avatar setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [self.view addSubview:avatar];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}
#pragma mark - 下载图片
void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL] ;
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}

-(void)AdImg:(NSArray*)arr{
//    [sv setContentSize:CGSizeMake(320*[arr count], 100)];
//    page.numberOfPages=[arr count];
//    
//    for ( int i=0; i<[arr count]; i++) {
//        NSString *url=[arr objectAtIndex:i];
//        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 44, 320, 100)];
//        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
//        [sv addSubview:img];
//        UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
//                       {
//                           [img setImage:image forState:UIControlStateNormal];
//                       }, ^(void){
//                       });
//    }
    [sv setContentSize:CGSizeMake(320*[_array count], 100)];
    page.numberOfPages = [_array count];
    for (int i=0; i<[_array count]; i++) {
        NSString *str = [_array objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 140)];
        [imgView setImage:[UIImage imageNamed:str]];
        [sv addSubview:imgView];
    }
    
}

-(void)Action{
    
    NSURL *theurl = [NSURL URLWithString:[Arr objectAtIndex:page.currentPage]];
    [wb loadRequest:[NSURLRequest requestWithURL:theurl]];
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"a.png"]];
        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
}

@end
