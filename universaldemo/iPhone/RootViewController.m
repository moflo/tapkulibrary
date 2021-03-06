//
//  RootViewController.m
//  Created by Devin Ross on 12/2/09.
//
/*
 
 tapku.com || http://github.com/tapku/tapkulibrary/tree/master
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "RootViewController.h"

#import "LabelViewController.h"
#import "FastTableViewController.h"
#import "HUDViewController.h"
#import "MapViewController.h"
#import "EmptyViewController.h"
#import "GraphController.h"
#import "DemoCalendarMonth.h"
#import "CoverflowViewController.h"
#import "MoreCellsViewController.h"
#import "AlertsViewController.h"
#import "ImageCenterViewController.h"
#import "TKCalendarWeekViewController.h"

@implementation RootViewController

- (id) initWithStyle:(UITableViewStyle)s{
	if(!(self = [super initWithStyle:s])) return nil;
	
	self.title = @"Tapku Library";
	self.tkBackButton = [[[TKBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:TKBarButtonItemStyleBack target:nil action:nil] autorelease];
	data = [[NSMutableArray alloc] init];
	

	
	NSArray *rows;
	NSDictionary *d;
	
	
	
	rows = [NSArray arrayWithObjects:@"Coverflow",@"Graph",@"Month Grid Calendar",@"Weekly Calendar",nil];
	d = [NSDictionary dictionaryWithObjectsAndKeys:rows,@"rows",@"Views",@"title",nil];
	[data addObject:d];
	
	rows = [NSArray arrayWithObjects:@"Empty Sign",@"Loading HUD",@"Alerts",@"Place Pins",nil];
	d = [NSDictionary dictionaryWithObjectsAndKeys:rows,@"rows",@"UI Elements",@"title",nil];
	[data addObject:d];
	
	//rows = [NSArray arrayWithObjects:@"Month",nil];
	//d = [NSDictionary dictionaryWithObjectsAndKeys:rows,@"rows",@"Calendar",@"title",nil];
	//[data addObject:d];
	
	
	rows = [NSArray arrayWithObjects:@"Label Cells",@"More Cells",@"Indicator Cells",nil];
	d = [NSDictionary dictionaryWithObjectsAndKeys:rows,@"rows",@"Table View Cells",@"title",@"",@"footer",nil];
	[data addObject:d];
	
	rows = [NSArray arrayWithObjects:@"Image Center",nil];
	d = [NSDictionary dictionaryWithObjectsAndKeys:rows,@"rows",@"Network",@"title",@"",@"footer",nil];
	[data addObject:d];
	
	return self;
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [data count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[data objectAtIndex:section] objectForKey:@"rows"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [[[data objectAtIndex:indexPath.section] objectForKey:@"rows"] objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
	
	
	
}
- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tv deselectRowAtIndexPath:indexPath animated:YES];
	
	
	UIViewController *vc;
	int s = indexPath.section, r = indexPath.row;
	
	if(s==0 && r < 2){
		
		if(r==0)
			vc = [[CoverflowViewController alloc] init];
		else 
			vc = [[GraphController alloc] init];
		
		[vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
		[self presentModalViewController:vc animated:YES];
		[vc release];
		return;
	}
	
	if(s==0&&r==2)
		vc = [[DemoCalendarMonth alloc] initWithSunday:YES];
	
	else if(s==0&&r==3)
		vc = [[TKCalendarWeekViewController alloc] init];		// Testing weekly view
	
	else if(s==1 && r==0)
		vc = [[EmptyViewController alloc] init];
	
	else if(s==1 && r==1)
		vc = [[HUDViewController alloc] init];
	else if(s==1 && r==2)
		vc = [[AlertsViewController alloc] init];
	else if(s==1 && r==3)
		vc = [[MapViewController alloc] init];
	
	
	/*
	else if(s==2 && r==0)
		vc = [[DemoCalendarMonth alloc] initWithSunday:YES];
	else if(s==2 && r==1)
		vc = [[TKCalendarDayViewController alloc] init];
	*/
	
	else if(s==2 && r==0)
		vc = [[LabelViewController alloc] initWithStyle:UITableViewStyleGrouped];
	else if(s==2 && r==1)
		vc = [[MoreCellsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	else if(s==2 && r==2)
		vc = [[FastTableViewController alloc] initWithStyle:UITableViewStylePlain];
	else
		vc = [[ImageCenterViewController alloc] initWithStyle:UITableViewStylePlain];
	
	
	
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
	
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [[data objectAtIndex:section] objectForKey:@"title"];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return [[data objectAtIndex:section] objectForKey:@"footer"];
}


- (void)dealloc {
	[data release];
    [super dealloc];
}


@end

