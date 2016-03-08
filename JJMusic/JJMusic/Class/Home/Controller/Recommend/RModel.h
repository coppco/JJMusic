//
//  RModel.h
//  JJMusic
//
//  Created by coco on 16/2/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//需要这样写上协议,才可以嵌套
@protocol Module
@end
@protocol Radio
@end
@protocol Focus
@end
@protocol Scene
@end
@protocol AllScene
@end
@protocol Recsong
@end
@protocol Mix_2
@end
@protocol Album
@end
@protocol Diy
@end
@protocol King
@end

//模块
@interface Module : JSONModel
HJpropertyCopy(NSString *pos);  //1
HJpropertyCopy(NSString *title_more);  //更多
HJpropertyCopy(NSString *jump);
HJpropertyCopy(NSString *title);  //标题
HJpropertyCopy(NSString *key);  //关键字
HJpropertyCopy(NSString *link_url);
@end

//乐播节目
@interface Radio : JSONModel
HJpropertyCopy(NSString *desc);  //描述  都市情感
HJpropertyCopy(NSString *itemid);   //条目id
HJpropertyCopy(NSString *title);  //标题
HJpropertyCopy(NSString *album_id);
HJpropertyCopy(NSString *type);  //类型
HJpropertyCopy(NSString *channelid);
HJpropertyCopy(NSString *pic);  //图片地址
@end

//焦点
@interface Focus : JSONModel
HJpropertyCopy(NSString *randpic);  //图片网址
HJpropertyCopy(NSString *code);  //网站
HJpropertyCopy(NSString *mo_type);
HJpropertyCopy(NSString *type);
HJpropertyCopy(NSString *is_publish);  //数字
HJpropertyCopy(NSString *randpic_iphone6);  //图片地址
HJpropertyCopy(NSString *randpic_desc);  //描述
@end

//场景电台
@interface Scene : JSONModel
HJpropertyCopy(NSString *icon_ios);  //图标地址
HJpropertyCopy(NSString *scene_name);  //名字
HJpropertyCopy(NSString *bgpic_android);
HJpropertyCopy(NSString *icon_android);
HJpropertyCopy(NSString *scene_model);
HJpropertyCopy(NSString *scene_desc);
HJpropertyCopy(NSString *bgpic_ios);
HJpropertyCopy(NSString *scene_id);
@end

@interface AllScene : JSONModel 
HJpropertyStrong(NSArray <Scene>*action);
HJpropertyStrong(NSArray <Scene>*emotion);
HJpropertyStrong(NSArray <Optional>*operation);
HJpropertyStrong(NSArray <Scene>*other);
@end

//今日推荐歌曲
@interface Recsong : JSONModel
HJpropertyCopy(NSString *song_id);  //歌曲id
HJpropertyCopy(NSString *title);  //标题
HJpropertyCopy(NSString *pic_premium);  //图片地址
HJpropertyCopy(NSString *author);  //作者
@end

//一个人的时候听
@interface Mix_2 : JSONModel
HJpropertyCopy(NSString *desc);
HJpropertyCopy(NSString *pic);
HJpropertyCopy(NSString *type_id);
HJpropertyCopy(NSString *type);
HJpropertyCopy(NSString *title);  //标题
HJpropertyCopy(NSString *tip_type);
HJpropertyCopy(NSString *author);
@end

//新碟上架
@interface Album : JSONModel
HJpropertyCopy(NSString *pic_radio);  //图片地址
HJpropertyCopy(NSString *all_artist_id);
HJpropertyCopy(NSString *songs_total);
HJpropertyCopy(NSString *pic_big);  //大图片地址
HJpropertyCopy(NSString *is_recommend_mis);
HJpropertyCopy(NSString *is_first_publish);
HJpropertyCopy(NSString *publishcompany); //海蝶音乐
HJpropertyCopy(NSString *country);  //内地
HJpropertyCopy(NSString *title);  //燕归巢
HJpropertyCopy(NSString *album_id);  //id
HJpropertyCopy(NSString *pic_small);  //小图片地址
HJpropertyCopy(NSString *artist_id);  //艺术家id  1483
HJpropertyCopy(NSString *is_exclusive);  //0
HJpropertyCopy(NSString *author);  //许嵩
@end

//歌单推荐
@interface Diy : JSONModel
HJpropertyCopy(NSString *pic);  //图片地址
HJpropertyCopy(NSString *title); //标题
HJpropertyCopy(NSString *tag); //标签
HJpropertyCopy(NSString *collectnum); //565
HJpropertyCopy(NSString *listid);  //6187
HJpropertyCopy(NSString *listenum); //152859
HJpropertyCopy(NSString *type);  //类型
@end

//百度king榜
@interface King : JSONModel
HJpropertyCopy(NSString *pic_big);  //图片地址
HJpropertyCopy(NSString *title);  //标题
HJpropertyCopy(NSString *author);  //作者
@end

/**
 NSMutableString <-> NSString
 NSMutableArray <-> NSArray
 NS(Mutable)Array <- JSONModelArray
 NSMutableDictionary <-> NSDictionary
 NSSet <-> NSArray
 BOOL <-> number/string
 string <-> number
 string <-> url
 string <-> time zone
 string <-> date
 number <-> date
 */
//加上Optional可以防止没有这个key会crash, ConvertOnDemand是延迟加载,Ignore忽略属性,不是从服务器获取

//不在同一层或者改变key 需要重写方法keyMapper

//嵌套的时候需要写协议,  并且加上<协议名>
@interface RModel : JSONModel
//不同层级的
HJpropertyStrong(NSArray<Radio> *radio);  //乐播节目
HJpropertyStrong(NSArray<Focus> *focus); //焦点图
HJpropertyStrong(AllScene *scene);  //场景电台
HJpropertyStrong(NSArray<Recsong> *recsong);  //今日推荐歌曲
HJpropertyStrong(NSArray<Mix_2> *mix_2);  //一个人的时候听
HJpropertyStrong(NSArray<Album> *album);   //新碟上架
HJpropertyStrong(NSArray<Diy> *diy);   //歌单推荐
HJpropertyStrong(NSArray<King> *king);  //百度king榜

//更改key值了
HJpropertyStrong(NSArray <Module> *module);  //模块
@end
