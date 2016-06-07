//
//  ViewController.m
//  FuckConatctsDemo
//
//  Created by bear on 16/6/7.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "ViewController.h"
#import "FuckContacts.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FuckContactsManager *manager = [[FuckContactsManager alloc   ]init];
    
    
     FuckContactModel *model =  [manager contactList].lastObject;
    
    
    NSLog(@">>>>>%@,%@",model.firstName,model.lastName);
    [model.phoneNumbers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@">>>>key:%@   , value :%@\n",key,obj);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
