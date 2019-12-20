//
//  LLViewController.m
//  LLPhotoBrowser
//
//  Created by LOLITA0164 on 12/19/2019.
//  Copyright (c) 2019 LOLITA0164. All rights reserved.
//

#import "LLViewController.h"
#import <LLImageBrowser/LLImageBrowser.h>

@interface LLViewController ()

@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)tap:(UIButton *)sender {
    
    NSArray* images = @[
        @"http://file02.16sucai.com/d/file/2014/0704/e53c868ee9e8e7b28c424b56afe2066d.jpg",
        @"http://file02.16sucai.com/d/file/2015/0408/779334da99e40adb587d0ba715eca102.jpg",
        @"http://file02.16sucai.com/d/file/2014/0829/372edfeb74c3119b666237bd4af92be5.jpg",
    ];
        
    [LLImageBrowser showURLImages:images placeholderImage:nil selectedIndex:0 selectedView:sender];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
