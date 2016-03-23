//
//  HJSearchDetaillController.m
//  JJMusic
//
//  Created by coco on 16/3/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSearchDetaillController.h"
#import "HJSearchDetailModel.h"
#import "HJSearchHeaderView.h"
#import "SingerModel.h"
#import "HJSingerController.h"

@interface HJSearchDetaillController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
HJpropertyStrong(UISearchBar *searchBar);
HJpropertyStrong(UITableView *tableView);
HJpropertyStrong(HJSearchDetailModel *detailModel);
@end

@implementation HJSearchDetaillController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchBar.text = self.key;
    self.title = STRFORMAT(@"搜索:%@", _key);
    [self loadDetailDataWithKey:_key];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self initNavi];
}
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}
- (void)initNavi {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.clearsContextBeforeDrawing = YES;
    self.searchBar.placeholder = @"歌曲|歌手|专辑|歌词|K歌";
    self.navigationItem.titleView = self.searchBar;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        _key = searchText;
        [self loadDetailDataWithKey:searchBar.text];
    } else {

    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}
- (void)loadDetailDataWithKey:(NSString *)key {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSearchDetail(key) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        self.detailModel = [[HJSearchDetailModel alloc] initWithDictionary:responseObject error:nil];
        [self.tableView reloadData];
    } failedBlock:^(NSError *error) {
        
    }];
}
#pragma mark - UITableViewDataSource 和 UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.detailModel == nil) {
        return 1;
    } else {
        return (self.detailModel.song_list.count != 0) + (self.detailModel.artist_list.count != 0) + (self.detailModel.album_list.count != 0);
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.detailModel == nil) {
        return 1;
    } else {
        NSInteger i = (self.detailModel.song_list.count != 0) + (self.detailModel.album_list.count != 0) + (self.detailModel.artist_list.count != 0);
        switch (i) {
            case 0:
            {
                return 0;
            }
                break;
            case 1:
            {
                if (self.detailModel.song_list.count != 0) {
                    
                    return self.detailModel.song_open == YES ? self.detailModel.song_list.count : 0;
                }
                if (self.detailModel.album_list.count != 0) {
                    return self.detailModel.album_open == YES ? self.detailModel.album_list.count : 0;
                }
                if (self.detailModel.artist_list.count != 0) {
                    return self.detailModel.artist_open == YES ? self.detailModel.artist_list.count : 0;
                }
            }
                break;
            case 2:
            {
                if (self.detailModel.song_list.count == 0) {
                    if (section == 0) {
                        return self.detailModel.album_open == YES ? self.detailModel.album_list.count : 0;
                    } else if (section == 1) {
                        return self.detailModel.artist_open == YES ? self.detailModel.artist_list.count : 0;
                    }
                }
                if (self.detailModel.album_list.count == 0) {
                    if (section == 0) {
                        return self.detailModel.song_open == YES ? self.detailModel.song_list.count : 0;
                    } else if (section == 1) {
                        return self.detailModel.artist_open == YES ? self.detailModel.artist_list.count : 0;
                    }
                }
                if (self.detailModel.artist_list.count == 0) {
                    if (section == 0) {
                        return self.detailModel.song_open == YES ? self.detailModel.song_list.count : 0;
                    } else if (section == 1) {
                        return self.detailModel.album_open == YES ? self.detailModel.album_list.count : 0;
                    }
                }
            }
                break;
            case 3:
            {
                if (section == 0) {
                    return self.detailModel.song_open == YES ? self.detailModel.song_list.count : 0;
                } else if (section == 1) {
                    return self.detailModel.album_open == YES ? self.detailModel.album_list.count : 0;
                } else if (section == 2){
                    return self.detailModel.artist_open == YES ? self.detailModel.artist_list.count : 0;
                }
            }
                break;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celll"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"celll"];
    }
    if (self.detailModel == nil) {
        cell.textLabel.text = @"暂无搜索结果";
    } else {
        cell.textLabel.attributedText = [self getTitleWithIndexPath:indexPath];
    }
    return cell;
}
- (NSMutableAttributedString *)getTitleWithIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    NSInteger i = (self.detailModel.song_list.count != 0) + (self.detailModel.album_list.count != 0) + (self.detailModel.artist_list.count != 0);
    switch (i) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (self.detailModel.song_list.count != 0) {
                title = STRFORMAT(@"%@-%@",[self.detailModel.song_list[indexPath.row] title],[self.detailModel.song_list[indexPath.row] author]);
            }
            if (self.detailModel.album_list.count != 0) {
                title = [self.detailModel.album_list[indexPath.row] title];
            }
            if (self.detailModel.artist_list.count != 0) {
                title = [self.detailModel.artist_list[indexPath.row] author];
            }
        }
            break;
        case 2:
        {
            if (self.detailModel.song_list.count == 0) {
                if (indexPath.section == 0) {
                    title = [self.detailModel.album_list[indexPath.row] title];
                } else if (indexPath.section == 1) {
                    title = [self.detailModel.artist_list[indexPath.row] title];
                }
            }
            if (self.detailModel.album_list.count == 0) {
                if (indexPath.section == 0) {
                    title = STRFORMAT(@"%@-%@",[self.detailModel.song_list[indexPath.row] title],[self.detailModel.song_list[indexPath.row] author]);
                } else if (indexPath.section == 1) {
                    title = [self.detailModel.artist_list[indexPath.row] author];
                }
            }
            if (self.detailModel.artist_list.count == 0) {
                if (indexPath.section == 0) {
                    title = STRFORMAT(@"%@-%@",[self.detailModel.song_list[indexPath.row] title],[self.detailModel.song_list[indexPath.row] author]);
                } else if (indexPath.section == 1) {
                    title = [self.detailModel.album_list[indexPath.row] title];
                }
            }
        }
            break;
        case 3:
        {
            if (indexPath.section == 0) {
                title = STRFORMAT(@"%@-%@",[self.detailModel.song_list[indexPath.row] title],[self.detailModel.song_list[indexPath.row] author]);
            } else if (indexPath.section == 1) {
                title = [self.detailModel.album_list[indexPath.row] title];
            } else if (indexPath.section == 2){
                title = [self.detailModel.artist_list[indexPath.row] author];
            }
        }
            break;
    }
    title = [title stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange range = [title rangeOfString:_key];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    return str;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HJSearchHeaderView *view = [HJSearchHeaderView searchHeaderView];
    [view setClickBlock:^(SearchHeaderType open) {
        switch (open) {
            case SearchHeaderTypeSong:
            {
                self.detailModel.song_open = !self.detailModel.song_open;
            }
                break;
            case SearchHeaderTypeAlbum:
            {
                self.detailModel.album_open = !self.detailModel.album_open;
            }
                break;
            case SearchHeaderTypeArtist:
            {
                self.detailModel.artist_open = !self.detailModel.artist_open;
            }
                break;
        }
        [self.tableView reloadData];
    }];
    view.array = [self getArrayWithSection:section];

    view.open = [self getTypeWithSection:section];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (NSArray *)getArrayWithSection:(NSInteger )section {
    NSArray *array = nil;
    NSInteger i = (self.detailModel.song_list.count != 0) + (self.detailModel.album_list.count != 0) + (self.detailModel.artist_list.count != 0);
    switch (i) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (self.detailModel.song_list.count != 0) {
                array = self.detailModel.song_list;
            }
            if (self.detailModel.album_list.count != 0) {
                array = self.detailModel.album_list;
            }
            if (self.detailModel.artist_list.count != 0) {
                array = self.detailModel.artist_list;
            }
        }
            break;
        case 2:
        {
            if (self.detailModel.song_list.count == 0) {
                if (section == 0) {
                    array = self.detailModel.album_list;
                } else if (section == 1) {
                   array = self.detailModel.artist_list;
                }
            }
            if (self.detailModel.album_list.count == 0) {
                if (section == 0) {
                   array = self.detailModel.song_list;
                } else if (section == 1) {
                    array = self.detailModel.artist_list;
                }
            }
            if (self.detailModel.artist_list.count == 0) {
                if (section == 0) {
                    array = self.detailModel.song_list;
                } else if (section == 1) {
                   array = self.detailModel.album_list;
                }
            }
        }
            break;
        case 3:
        {
            if (section == 0) {
                array = self.detailModel.song_list;
            } else if (section == 1) {
                array = self.detailModel.album_list;
            } else if (section == 2){
                array = self.detailModel.artist_list;
            }
        }
            break;
    }
    return array;
}
- (SearchHeaderType)getTypeWithSection:(NSInteger )section {
    SearchHeaderType type;
    NSInteger i = (self.detailModel.song_list.count != 0) + (self.detailModel.album_list.count != 0) + (self.detailModel.artist_list.count != 0);
    switch (i) {
        case 0:
        {
            return type;
        }
            break;
        case 1:
        {
            if (self.detailModel.song_list.count != 0) {
                type = SearchHeaderTypeSong;
            }
            if (self.detailModel.album_list.count != 0) {
                type = SearchHeaderTypeAlbum;
            }
            if (self.detailModel.artist_list.count != 0) {
                type = SearchHeaderTypeArtist;
            }
        }
            break;
        case 2:
        {
            if (self.detailModel.song_list.count == 0) {
                if (section == 0) {
                    type = SearchHeaderTypeAlbum;
                } else if (section == 1) {
                    type = SearchHeaderTypeArtist;
                }
            }
            if (self.detailModel.album_list.count == 0) {
                if (section == 0) {
                    type = SearchHeaderTypeSong;
                } else if (section == 1) {
                    type = SearchHeaderTypeArtist;
                }
            }
            if (self.detailModel.artist_list.count == 0) {
                if (section == 0) {
                    type = SearchHeaderTypeSong;
                } else if (section == 1) {
                    type = SearchHeaderTypeAlbum;
                }
            }
        }
            break;
        case 3:
        {
            if (section == 0) {
                type = SearchHeaderTypeSong;
            } else if (section == 1) {
                type = SearchHeaderTypeAlbum;
            } else if (section == 2){
               type = SearchHeaderTypeArtist;
            }
        }
            break;
    }
    return type;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.detailModel != nil) {
        NSInteger i = (self.detailModel.song_list.count != 0) + (self.detailModel.album_list.count != 0) + (self.detailModel.artist_list.count != 0);
        switch (i) {
            case 0:
            {
                return ;
            }
                break;
            case 1:
            {
                if (self.detailModel.song_list.count != 0) {
                }
                if (self.detailModel.album_list.count != 0) {
                }
                if (self.detailModel.artist_list.count != 0) {
                    [self gotoSingerVCWithIndexPath:indexPath];
                }
            }
                break;
            case 2:
            {
                if (self.detailModel.song_list.count == 0) {
                    if (indexPath.section == 0) {

                    } else if (indexPath.section == 1) {
                        [self gotoSingerVCWithIndexPath:indexPath];
                    }
                }
                if (self.detailModel.album_list.count == 0) {
                    if (indexPath.section == 0) {

                    } else if (indexPath.section == 1) {
                        [self gotoSingerVCWithIndexPath:indexPath];
                    }
                }
                if (self.detailModel.artist_list.count == 0) {
                    if (indexPath.section == 0) {

                    } else if (indexPath.section == 1) {

                    }
                }
            }
                break;
            case 3:
            {
                if (indexPath.section == 0) {
                    Song_list *list = self.detailModel.song_list[indexPath.row];
                    getApp().playerView.songID = list.song_id;
                    NSMutableArray *arrayM = [NSMutableArray array];
                    for (Song_list *list1 in self.detailModel.song_list) {
                        [arrayM addObject:list1.song_id];
                    }
                    getApp().playerView.content = arrayM;
                    [getApp() playerViewAppear:nil];
                } else if (indexPath.section == 1) {

                } else if (indexPath.section == 2){
                    [self gotoSingerVCWithIndexPath:indexPath];
                }
            }
                break;
        }
    }
}
- (void)gotoSingerVCWithIndexPath:(NSIndexPath *)indexPath {
    Artist_list *list = self.detailModel.artist_list[indexPath.row];
    SingerModel *model =  [[SingerModel alloc] initWithString:[list toJSONString] error:nil];
    HJSingerController *singerVC = [[HJSingerController alloc] init];
    singerVC.singer = model;
    [self.navigationController pushViewController:singerVC animated:YES];
}
@end
