//
//  SubjectModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface SubjectModel : BaseModel

/*
"ad_id": "6",
"items": [
          {
              "url": "http://www.0gow.com/login/wx?reffer=http%3a%2f%2fwww.0gow.com%2fsubject%2f113",
              "image": "http://p4.0gow.com/content0gow_57b2b3910f967?imageMogr2/strip/quality/80/format/jpg",
              "title": "车饰节",
              "appurl": "http://www.0gow.com/login/wx?reffer=http%3a%2f%2fwww.0gow.com%2fappsubject%2f113"
          }
*/

@property (nonatomic, strong) NSString *ad_id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *appurl;

@end
