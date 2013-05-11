//
//  ViewController.h
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    IBOutlet UIScrollView *sv;
    IBOutlet UIPageControl *page;
    IBOutlet UIWebView *wb;
    NSArray *Arr;
    int TimeNum;
    BOOL Tend;
}

@end
