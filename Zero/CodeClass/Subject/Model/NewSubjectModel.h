//
//  NewSubjectModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface NewSubjectModel : BaseModel

/*
 "id": "125",
 "title": "开学囤货季",
 "url": "",
 "bgcolor": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_57bbe040c3d85?imageMogr2/quality/80/format/jpg",
 "cat_id": "1",
 "goods_id": "172585,56646,173886,88728,95899,152801,62602,27932,152791,151340,114239,27934,56290,109500,48871,135394,191743,102522,159910,87116,115872,114302,130788,57400,139912,50861,66251,50120,67534,170593,26552,125720,55342,60461,46876,57188,134770,57941,56299,170468,87153,45724,33401,10963,69182,141834,182295,90841,119258,11859,100738,80570,188117,168700,204289,149784,81193,127034,150416,177773,115877,93511,64637,47756,70179,56911,33917,11808,41671,47569,136165,78203,53410,78334,34792,77863,21781,52952,149716,145493,113111,174685,180744,108360,180587,147664,148596,58286,109423,108376,149775,127318,113678,64969,57943,60828,78814,64598,29614,112996,77937,78231,56654,167492,177799,177762,179089,178578,177485,119307,64933,70241,24775,52541,163093,208139,183615,184459,177214,177787,129733,181159,202579,179977,137060,174753,151383,143276,151007,188974,158936,181168,98027,189942,181106,133942,202512,178579,165952,178671,164577,173861,189736,199255,175402,181242,177298,142424,165721,133325",
 "banner": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_57bbe040c3d85?imageMogr2/quality/80/format/jpg",
 "view": "0",
 "sort": "100",
 "addtime": "2016-08-23 13:33:20",
 "goods_count": 150
 */
@property (nonatomic, copy) NSString *subject_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *bgcolor;
@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, copy) NSString *view;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *goods_count;

@end
