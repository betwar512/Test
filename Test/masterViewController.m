//
//  masterViewController.m
//  Test
//
//  Created by Abbi H Safaie on 3/05/2014.
//  Copyright (c) 2014 Abbas H Safaie. All rights reserved.
//

#import "masterViewController.h"


@interface masterViewController ()

@end

@implementation masterViewController

//protocol method to dissmis viewController

-(void)detaiViewWillDis:(DetailViewController*)DetailViewController{

           [self.tableView reloadData];
    
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

// nsmanagedObject method to return context for edit

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueH.jpg"]]];
    
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    
    self.fetchedFavaroutsArray=[appDelegate getAllFavarouts];

     
    [self.tableView reloadData];
    
    //use notifacation to give last change to save include block to run saveContext method inside appdelegate
    
    NSNotificationCenter * center=[NSNotificationCenter defaultCenter];
    [center addObserverForName:@"saveNow" object:nil queue:nil usingBlock:^(NSNotification *note) {
          [appDelegate saveContext];
        
    }];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//number of sections in table Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

//return number of rows in table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.fetchedFavaroutsArray.count;
}

//custome and create  cell for our table with data

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Favarouts*favarout=[self.fetchedFavaroutsArray objectAtIndex:indexPath.row];

    
   //get image data out of our data
    UIImage * myImage = [UIImage imageWithData:favarout.image];
    
    //    [cell.imageView setImage:myImage];
    cell.imageView.image=myImage;

    //set text for title and suntitle in our cell
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",favarout.name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",favarout.url];
    
    return cell;
}

// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

         NSManagedObjectContext *context = [self managedObjectContext];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source

    //remove it from our context
      [context deleteObject:[self.fetchedFavaroutsArray objectAtIndex:indexPath.row]];
        
                [self.fetchedFavaroutsArray removeObjectAtIndex:indexPath.row];
        
    //remove object from mutablearray
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    
    [self performSegueWithIdentifier:@"accessoryWay" sender:self];

}
*/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    
    //cell push model segue to RootViewController
    
    if ([[segue identifier] isEqualToString:@"cellWay"]) {
        
     Favarouts*favarout=[self.fetchedFavaroutsArray objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        RootViewController*rvc=[segue destinationViewController];
        rvc.url=favarout.url;
    
    }
    
    //accessory model segue DetailView
    
    if ([[segue identifier] isEqualToString:@"accessoryWay"]) {
  
        //get indexPath for selected row
        
   NSIndexPath *myIndex = [self.tableView indexPathForCell:sender];
        
        DetailViewController* dvc=[segue destinationViewController];
        
     Favarouts*favarout=[self.fetchedFavaroutsArray objectAtIndex:myIndex.row];
        
        dvc.favarout=favarout;
        dvc.delegate=self;
    
    }
}


@end
