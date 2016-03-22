//
//  HJSearchController.m
//  JJMusic
//
//  Created by coco on 16/3/21.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSearchController.h"
#import "HJHostorySearchDB.h"  //搜索数据库
#import "HJSearchModel.h"  //搜索model
#import "HJSearchDetaillController.h"  //搜索详情

@interface HJSearchController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
HJpropertyStrong(UISearchBar *searchBar);
HJpropertyStrong(HJSearchModel *searchModel);  //搜索结果
HJpropertyStrong(UITableView *tableView);  //表视图
HJpropertyStrong(NSMutableArray *hostoryArray);  //历史搜索数据
@end

@implementation HJSearchController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hostoryArray = [HJHostorySearchDB getAllHostorySearchResult].mutableCopy;
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
        [self loadDataWithKey:searchBar.text];
    } else {
        self.searchModel = nil;
        self.hostoryArray = [HJHostorySearchDB getAllHostorySearchResult].mutableCopy;
        [self.tableView reloadData];
    }
}
//搜索按钮点击的时候
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //添加到数据库
    if ([HJHostorySearchDB isHasHostoryWithTitle:searchBar.text]) {
        //数据库有  更新
        [HJHostorySearchDB updateOneHostorySearchResultWithTitle:searchBar.text];
    } else {
        //数据库没有
        [HJHostorySearchDB addOneHostorySearchResultWithTitle:searchBar.text];
    }
    [_searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
}
//加载搜索结果
- (void)loadDataWithKey:(NSString *)key {
    [HttpHandleTool requestWithType:(HJNetworkTypeGET) URLString:kSearch(key) params:nil showHUD:NO inView:nil cache:YES successBlock:^(id responseObject) {
        self.searchModel = [[HJSearchModel alloc] initWithDictionary:responseObject error:nil];;
        [self.tableView reloadData];
    } failedBlock:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource 和 UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.searchModel == nil) {
        return 1;
    } else {
        return (self.searchModel.song.count != 0) + (self.searchModel.album.count != 0) + (self.searchModel.artist.count != 0);
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchModel == nil) {
        return self.hostoryArray.count + 1;
    } else {
        NSInteger i = (self.searchModel.song.count != 0) + (self.searchModel.album.count != 0) + (self.searchModel.artist.count != 0);
        switch (i) {
            case 0:
            {
                return 0;
            }
                break;
            case 1:
            {
                if (self.searchModel.song.count != 0) {
                    return self.searchModel.song.count;
                }
                if (self.searchModel.album.count != 0) {
                    return self.searchModel.album.count;
                }
                if (self.searchModel.artist.count != 0) {
                    return self.searchModel.artist.count;
                }
            }
                break;
            case 2:
            {
                if (self.searchModel.song.count == 0) {
                    if (section == 0) {
                        return self.searchModel.album.count;
                    } else if (section == 1) {
                        return self.searchModel.artist.count;
                    }
                }
                if (self.searchModel.album.count == 0) {
                    if (section == 0) {
                        return self.searchModel.song.count;
                    } else if (section == 1) {
                        return self.searchModel.artist.count;
                    }
                }
                if (self.searchModel.artist.count == 0) {
                    if (section == 0) {
                        return self.searchModel.song.count;
                    } else if (section == 1) {
                        return self.searchModel.album.count;
                    }
                }
            }
                break;
            case 3:
            {
                if (section == 0) {
                    return self.searchModel.song.count;
                } else if (section == 1) {
                    return self.searchModel.album.count;
                } else if (section == 2){
                    return self.searchModel.artist.count;
                }
            }
                break;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"index"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"index"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (self.searchModel == nil) {
        if (self.hostoryArray.count == 0) {
            cell.textLabel.text = @"暂无历史记录";
            cell.textLabel.textAlignment = 0;
        } else {
            if (indexPath.row == self.hostoryArray.count) {
                cell.textLabel.text = @"清除历史记录";
                cell.textLabel.textAlignment = 1;
            } else {
                cell.textLabel.text = self.hostoryArray[indexPath.row][@"title"];
                cell.textLabel.textAlignment = 0;
            }
        }
    } else {
         cell.textLabel.textAlignment = 0;
        cell.textLabel.text = [self getTitleWithIndexPath:indexPath];
    }
    
    return cell;
}
- (NSString *)getTitleWithIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    NSInteger i = (self.searchModel.song.count != 0) + (self.searchModel.album.count != 0) + (self.searchModel.artist.count != 0);
    switch (i) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (self.searchModel.song.count != 0) {
                title = [self.searchModel.song[indexPath.row] songname];
            }
            if (self.searchModel.album.count != 0) {
                title = [self.searchModel.album[indexPath.row] albumname];
            }
            if (self.searchModel.artist.count != 0) {
                title = [self.searchModel.artist[indexPath.row] artistname];
            }
        }
            break;
        case 2:
        {
            if (self.searchModel.song.count == 0) {
                if (indexPath.section == 0) {
                    title = [self.searchModel.album[indexPath.row] albumname];
                } else if (indexPath.section == 1) {
                    title = [self.searchModel.artist[indexPath.row] artistname];
                }
            }
            if (self.searchModel.album.count == 0) {
                if (indexPath.section == 0) {
                    title = [self.searchModel.song[indexPath.row] songname];
                } else if (indexPath.section == 1) {
                    title = [self.searchModel.artist[indexPath.row] artistname];
                }
            }
            if (self.searchModel.artist.count == 0) {
                if (indexPath.section == 0) {
                    title = [self.searchModel.song[indexPath.row] songname];
                } else if (indexPath.section == 1) {
                    title = [self.searchModel.album[indexPath.row] albumname];
                }
            }
        }
            break;
        case 3:
        {
            if (indexPath.section == 0) {
                title = [self.searchModel.song[indexPath.row] songname];
            } else if (indexPath.section == 1) {
                title = [self.searchModel.album[indexPath.row] albumname];
            } else if (indexPath.section == 2){
                title = [self.searchModel.artist[indexPath.row] artistname];
            }
        }
            break;
    }
    return title;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.searchModel == nil) {
        return @"历史搜索记录";
    } else {
        NSInteger i = (self.searchModel.song.count != 0) + (self.searchModel.album.count != 0) + (self.searchModel.artist.count != 0);
        switch (i) {
            case 0:
            {
                return @"搜索结果";
            }
                break;
            case 1:
            {
                if (self.searchModel.song.count != 0) {
                    return @"搜索到的歌曲";
                }
                if (self.searchModel.album.count != 0) {
                    return @"搜索到的专辑";
                }
                if (self.searchModel.artist.count != 0) {
                    return @"搜索到的歌手";
                }
            }
                break;
            case 2:
            {
                if (self.searchModel.song.count == 0) {
                    if (section == 0) {
                        return @"搜索到的专辑";
                    } else if (section == 1) {
                        return @"搜索到的歌手";
                    }
                }
                if (self.searchModel.album.count == 0) {
                    if (section == 0) {
                        return @"搜索到的歌曲";
                    } else if (section == 1) {
                       return @"搜索到的歌手";
                    }
                }
                if (self.searchModel.artist.count == 0) {
                    if (section == 0) {
                        return @"搜索到的歌曲";
                    } else if (section == 1) {
                        return @"搜索到的专辑";
                    }
                }
            }
                break;
            case 3:
            {
                if (section == 0) {
                    return @"搜索到的歌曲";
                } else if (section == 1) {
                    return @"搜索到的专辑";
                } else if (section == 2){
                    return @"搜索到的歌手";
                }
            }
                break;
        }
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchModel == nil) {
        //点击历史搜索
        if (self.hostoryArray.count == 0) {
            
        } else {
            if (indexPath.row == self.hostoryArray.count) {
                self.hostoryArray = nil;
                [HJHostorySearchDB deleteAllHostory];
                [self.tableView reloadData];
            } else {
                self.searchBar.text = self.hostoryArray[indexPath.row][@"title"];
                [self loadDataWithKey:self.hostoryArray[indexPath.row][@"title"]];
            }
        }
    } else {
        //搜索详情的东西
        HJSearchDetaillController *searchDetailVC = [[HJSearchDetaillController alloc] init];
        searchDetailVC.key = [self getTitleWithIndexPath:indexPath];
        [self.navigationController pushViewController:searchDetailVC animated:YES];
    }
}
@end
