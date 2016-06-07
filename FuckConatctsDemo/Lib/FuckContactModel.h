//
//  FuckContact.h
//  FuckContacts
//
//  Created by bear on 16/6/7.
//  Copyright © 2016年 bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuckContactModel : NSObject



/**
 *  FirstName  GivenName
 */
@property (nonatomic, copy) NSString *firstName;


/**
 *  lastName familyName
 */
@property (nonatomic, copy) NSString *lastName;



/**
 *  MiddleName
 */
@property (nonatomic, copy) NSString *middleName;



@property (nonatomic, strong) NSDictionary *phoneNumbers;



@property (nonatomic, copy) NSString *PhoneNumberMobile;



@property (nonatomic, copy) NSString *PhoneNumberiPhone;



@property (nonatomic, copy) NSString *PhoneNumberMain;


@end
