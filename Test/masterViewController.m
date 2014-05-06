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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

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
   
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_view.jpeg"]]];
    
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    
    self.fetchedFavaroutsArray=[appDelegate getAllFavarouts];
    

    
    [self.tableView reloadData];
    
    
    
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

#pragma mark - Table view data source

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

//create cell for our table with data

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Favarouts*favarout=[self.fetchedFavaroutsArray objectAtIndex:indexPath.row];
    
    
    NSString* imageUrl=favarout.imageUrl;
    
    NSURL * imageURL = [NSURL URLWithString:imageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * myImage = [UIImage imageWithData:imageData];
    
    //    [cell.imageView setImage:myImage];
    cell.imageView.image=myImage;

    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",favarout.name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",favarout.url];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"cellWay"]) {
        
 Favarouts*favarout=[self.fetchedFavaroutsArray objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        RootViewController*rvc=[segue destinationViewController];
        rvc.urlTextfield.text=favarout.url;
    
    
    }
    
    if ([[segue identifier] isEqualToString:@"accessoryWay"]) {
    
        
        
        
    }
    
    

}


@end
