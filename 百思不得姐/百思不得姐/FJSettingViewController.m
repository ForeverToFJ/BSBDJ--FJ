//
//  FJSettingViewController.m
//  百思不得姐
//
//  Created by  高帆 on 16/6/1.
//  Copyright © 2016年  高帆. All rights reserved.
//

#import "FJSettingViewController.h"
#import <SDImageCache.h>

@interface FJSettingViewController ()

@end

@implementation FJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"设置";
    self.tableView.backgroundColor = FJGlobalBG;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self getSize];
}

- (void)getSize {
    // 缓存
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    //    NSLog(@"%zd -> %@", size, NSTemporaryDirectory());
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 获得文件夹内部所有内容
//    NSArray *contents = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    NSArray *subpaths = [manager subpathsAtPath:cachePath];
    
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
    
    NSInteger *totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        
        //        BOOL dir = NO;
        //        [manager fileExistsAtPath:filePath isDirectory:&dir];
        //        if (dir) {
        //            continue;
        //        }
        NSDictionary *attrs = [manager attributesOfItemAtPath:cachePath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        //        NSInteger size = [[manager attributesOfItemAtPath:filePath error:nil][NSFileSize] integerValue];
        totalSize += [attrs[NSFileSize] integerValue];
    }
    NSLog(@"%zd", totalSize);
    
    //    NSDictionary *attrs = [manager attributesOfItemAtPath:cachePath error:nil];
    //    
    //    NSLog(@"%@", attrs);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.1fM)", size / 1024.0 / 1024.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[SDImageCache sharedImageCache] clearDisk];
    [tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
