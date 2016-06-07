//
//  FuckContactsManager.m
//  FuckContacts
//
//  Created by bear on 16/6/7.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "FuckContactsManager.h"
#import "FuckContactModel.h"

@implementation FuckContactsManager


+(void)initialize{
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    // 2.判断授权状态
    if (status == kABAuthorizationStatusNotDetermined) {// 未授权
        // 3.创建通讯录
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
        // 4.请求授权
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"授权成功");
            }
        });
    }
    
}
-(NSArray *)contactList{
    // 1.获取所有的数据
    // 1.1获取通讯录
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    // 1.2获取所有联系人的数据
    CFArrayRef peoples = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    // 2.获取某一个人的数据
    // 2.1获取长度
    CFIndex peoplesCount = CFArrayGetCount(peoples);
    // 2.2遍历数组
    
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=0; i<peoplesCount; i++) {
        
        FuckContactModel *contact = [FuckContactModel new];
        
        // 2.3获取具体联系人的数据
        ABRecordRef person = CFArrayGetValueAtIndex(peoples, i);
        // 3.获取电话和姓名
        // 3.1获取姓名
        contact.firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        contact.lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSLog(@"firstName:%@   lastName:%@",contact.firstName,contact.lastName);
        // 3.2获取电话
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        // 3.3获取长度
        CFIndex phonesCount = ABMultiValueGetCount(phones);
        // 3.4遍历所有电话
        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
        for (int i=0; i<phonesCount; i++) {
            
       
         
            NSString *label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, i));
            NSString *value = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
            
            
            if ([label containsString:@"_$!<"]) {
                NSRange startMarkRange= [label rangeOfString:@"_$!<"];
                
                NSRange endMarkRange =[label rangeOfString:@">!$_"];
                
                label =[label substringWithRange:NSMakeRange(startMarkRange.location+startMarkRange.length, endMarkRange.location-(startMarkRange.location+startMarkRange.length))];
                
                
            }
            
            if (label !=nil && value != nil) {
                
                
                [phoneDict setValue:(NSString *)value forKey:(NSString *)label];
            }
            
   
            contact.phoneNumbers =  phoneDict;
            
        }
        [arrayM addObject:contact];
        CFRelease(phones);
        
       
    }
    
    
    CFRelease(addressBook);
    CFRelease(peoples);
    
    
    return arrayM;
    
}
@end
