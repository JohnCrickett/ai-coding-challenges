Feature: Event Finder 

The application maintains a set of events provided by organizations that can be searched by users so they can determine what events they may wish to attend

The application can run in a browser.  Alternatively, it can be a smart phone app (Android and IPhone).  


Scenario: Domain Term MaintainingUser 
* MaintainingUser has  
| FirstName | LastName | Email | Organization |

# Email should be confirmed by sending an email with a code 
# Logon can be verified by either sending a code or a link or password (optional)

Scenario: Domain Term SearchingUser 
* SearchingUser have 
| Email | Location |

# SearchingUser does not have to be registered, unless they wish to save search criteria 

Scenario: Add an event
Given events are:
| Name  | Date  | Time  | Duration | Venue | Location  | Description  | Tags  | Link |  
And logged in MaintainingUser is 
| Organization  |
| MLK Committee | 
When event is added 
| Name         |  Film Screening of John Lewis |
| Date         |  January 16, 2026 |
| Time         |  7:30 PM  |
| Duration     |  2 hours |
| Venue        |  Carolina Theater |
| Location     | 309 West Morgan St, Durham, NC 27701 |
| Description  |  Engaging movie on life of John Lewis |
| Tags         |  MLK, Film |
| Cost         |  0 |
| Link         | https://carolinatheater.com/John_Lewis
Then events are now: 
| Name                          | Date              | Time     | Duration  | Venue             | Location                              | Description                           | Tags       | Cost  | Link | Organization | 
| Film Screening of John Lewis  | January 16, 2026  | 7:30 PM  | 2 hours   | Carolina Theater  | 309 West Morgan St, Durham, NC 27701  | Engaging movie on life of John Lewis  | MLK, Film  | $0    | https://carolinatheater.com/John_Lewis | MLK Committee | 

# Name and Description should be alphanumeric strings with commas and periods allowed.
# Link should be checked for accessibility 

Scenario:  Add events with spreadsheet 
Given logged in as MaintainingUser 
When spreadsheet containing event information is uploaded 
Then information is validated and added to events 
# If invalid information, the event should not be added 
# Duplicate events should be discarded 

Scenario: Delete events 
Given logged in as MaintainingUser 
When an event is deleted 
Then it is removed from list of events
# Only events for the organization can be deleted  


Scenario: Domain Term Cost
* Cost can be Single cost or  Range of costs 
# Cost is in local currency 

Scenario: Domain Term Location 
* Location contains 
| Line1 | Line2 | City | State | Zip |
# Locations should be validated using https://developers.usps.com/addressesv3

Scenario: Domain Term Date 
* Date contains
| Month | Day | Year |
# Dates should be validated 

Scenario: Domain Term Time
* Time contains 
| Hour | Minute | Meridiem | 
# Time should be validated 
# Time zone is based on Location 


Scenario: Search for Event
Given events are:
| Name    | Date       | Time     | Dur.  | Venue     | Location               | Description  | Tags     |
| EventA  | 1/15/2026  | 4:30 PM  | 2     | Carolina  | 1 West St, Durham, NC  | Nice event   | Film,    |
| EventB  | 1/16/2026  | 5:00 PM  | 1     | DPAC      | 2 East St, Chapel, NC  | Great event  | Concert  |
| EventC  | 1/15/2026  | 6:00 PM  | 3     | DPAC      | 1 West St, Durham, NC  | Great event  | Concert  |
When searched by
| Date    | 1/15/2026  | 
Then results are 
| Name    | Date       | Time     | Dur.  | Venue     | Location               | Description  | Tags     |
| EventA  | 1/15/2026  | 4:30 PM  | 2     | Carolina  | 1 West St, Durham, NC  | Nice event   | Film,    |
| EventC  | 1/15/2026  | 6:00 PM  | 3     | DPAC      | 1 West St, Durham, NC  | Great event  | Concert  |
When searched by
| Tag     | Concert    | 
Then results are 
| Name    | Date       | Time     | Dur.  | Venue     | Location               | Description  | Tags     |
| EventB  | 1/16/2026  | 5:00 PM  | 1     | DPAC      | 2 East St, Chapel, NC  | Great event  | Concert  |
| EventC  | 1/15/2026  | 6:00 PM  | 3     | DPAC      | 1 West St, Durham, NC  | Great event  | Concert  |
When searched by
| Date    | 1/15/2026  |
| Tag     | Concert    | 
Then results are 
| Name    | Date       | Time     | Dur.  | Venue     | Location               | Description  | Tags     |
| EventC  | 1/15/2026  | 6:00 PM  | 3     | DPAC      | 1 West St, Durham, NC  | Great event  | Concert  |

# Events should be searchable by Date , Time, Name, Venue, Description, and Tags 
# Link should appear on the search results 

# Events should also be searchable by Distance.   This will require the user to input their location.  
Scenario: Domain Term Distance 
* Distance between two places 
| SearchingUser Location | Event Location | Distance | 

# Distance should use an open source API to determine the distance 

# Extensions:  Events that occur multiple times - either on same day or different days.  

