//
//  CollectionVC.m
//  A_program_music
//
//  Created by dlios on 15/6/29.
//  Copyright (c) 2015年 CHD. All rights reserved.
//

#import "CollectionVC.h"
#import "PlayModel.h"

@interface CollectionVC ()

@property(nonatomic,retain)UITableView *tableview1;
@property(nonatomic,retain)UIImageView *imageview1;

@end

@implementation CollectionVC

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview1 deselectRowAtIndexPath:[self.tableview1 indexPathForSelectedRow] animated:YES];
    if (self.array.count == 0) {
        self.imageview1.hidden = NO;
    }
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
  
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_arrow"] style:UIBarButtonItemStyleDone target:self action:@selector(pushToRightMenu)] autorelease];
    self.navigationItem.title = @"我的收藏";

    self.tableview1 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview1.dataSource = self;
    self.tableview1.delegate = self;
    [self.view addSubview:self.tableview1];
    self.tableview1.separatorStyle = 0;
self.tableview1.backgroundColor = [UIColor colorWithRed:143.0/255 green:172.0/255 blue:193.0/255 alpha:1];
    
    self.array = [NSMutableArray array];
    self.array = [[CollectSQL shareSQL] selectAllSCPlayModel];
    
    self.imageview1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content-empty"]];
    [self.tableview1 addSubview:self.imageview1];
    self.imageview1.hidden = YES;
    
    
  /*  if (self.array.count == 0) {
        
       
        UIAlertView  *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alerview show];
        
    }

   */
    
    
    
}
/*-(void)viewWillAppear:(BOOL)animated{
    [self.tableview1 reloadData];
}
*/

-(void)pushToRightMenu
{
    [self.sideMenuViewController presentRightMenuViewController];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    PlayModel *playModel = [[PlayModel alloc] init];
    playModel = [self.array objectAtIndex:indexPath.row];
    
    NSString *str = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];
    cell.number = str;
    cell.playModel = playModel;
    
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingController *playVC = [PlayingController PlayingBox];
    playVC.playArray = self.array;
    playVC.indexPath = indexPath.row;
    
    
   [self presentViewController:playVC animated:YES completion:^{
       
       
   }];
}

//-----------------删除收藏-------------------
//导航栏右侧编辑按钮触发方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.tableview1 setEditing:editing animated:animated];
}

//询问哪些行需要编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return YES;
}
//设置编辑类型:删除或者插入
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return UITableViewCellEditingStyleDelete;
 
}
//实现编辑逻辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayModel *playModel = [[PlayModel alloc] init];
    playModel = [self.array objectAtIndex:indexPath.row];
    [self.array removeObjectAtIndex:indexPath.row];
    [[CollectSQL shareSQL] deleteSCMusicWithPlayModel:playModel];
//    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    
    if (self.array.count == 0) {
        [[CollectSQL shareSQL] deleteAllSCPlayMusic];
//        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
        UIAlertView  *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alerview show];
        self.imageview1.hidden = NO;
        
    }
    
    [self.tableview1 reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return @"删除";
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
