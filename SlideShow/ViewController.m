//
//  ViewController.m
//  SlideShow
//
//  Created by Vicky Mathneja on 14/02/15.
//  Copyright (c) 2015 MINE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
     NSArray *Arr;
    int TimeNum;
    BOOL Tend;
    int rowindex;
    IBOutlet UIScrollView *sv;
    IBOutlet UIPageControl *page;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    //SlideShow Image Array
    Arr=[[NSArray alloc]initWithObjects:
         @"2_cloud.png",@"2.png",@"cloudwords.png",@"k.png",nil];
    
    //Add Image to ScrollView
    [self AdImg:Arr];

    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - timer
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
        
        [UIView animateWithDuration:0.7 //
                         animations:^{//
                             sv.contentOffset = CGPointMake(page.currentPage*self.view.frame.size.width,0);
                         }];
        
        
    }
    TimeNum ++;
}
-(void)AdImg:(NSArray*)arr{
    //sv.frame=CGRectMake(0, 5+64, 320, 150);
    NSLog(@"%@",sv);
    
    [sv setContentSize:CGSizeMake(self.view.frame.size.width*[arr count], self.view.frame.size.height)];
    page.numberOfPages=[arr count];
    
    for (UIView*v in sv.subviews){
        [v removeFromSuperview];
    }
    
    for ( int i=0; i<[arr count]; i++) {
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        img.image=[UIImage imageNamed:[arr objectAtIndex:i]];
        img.tag=i;
        [sv addSubview:img];
        
        
    }
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/self.view.frame.size.width;
    // [self setCurrentPage:page.currentPage];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
