# Database Design Project

This repository contains schema, sample data, queries, and documentation for a database design project.

## Purpose
The purpose of this database is to store information related to US state data center locations, state industries, and total state utility (e.g. water, electricity, natural gas), and AI activity (e.g. VC deals and funding, metropolitan area rankings in AI performance) in one convenient place. 

The project is inspired by [Business Insider’s](https://www.businessinsider.com/data-center-locations-us-map-ai-boom-2025-9) extensive efforts to map US data centers, and it should serve to aid various students and professionals in energy, environmental, and other related policy fields.

## Users & Information Needs
Key users of this database would include policy analysts or researchers, or students –  those interested in things such as understanding utility usage trends, examining historical utility price data, and exploring the connection between utility consumption trends and data center locations in the US. Data around data center locations in the US tend to be disparate, particularly when it comes to data center utility consumption such as electricity, natural gas, and water. 

Data around historical residential and industry energy usage and prices is more widely available via open government databases, but connecting the two areas of data within a relational database will help researchers further explore the potential connections between data center location energy usage and wider industry energy usage. 

#### Business Rules
##### Location & Industry 
- ###### A state can have many counties. 
- ###### Many counties can be located in a state. 

- ###### A data center is located in a county. 
- ###### A county may have many data centers. 

- ###### Each state has industries. 
- ###### Industries are in many states.

- ###### Each state has metropolitan areas. 
- ###### A metropolitan area can belong to one or many states. 

##### Utility Consumption 
- ###### A state records many utility measures. 
- ###### There are utility measurements in many states. 

- ###### A data center records many utility measurements. 
- ###### There are utility measurements for many data centers. 

- ###### Each industry records many utility measures. 
- ###### There are utility measures recorded for each industry.

- ###### Each industry records many utility measures by state. 
- ###### There are utility measures for each state industry.

##### AI Activity & Performance
- ###### Each metropolitan area has an AI performance tier classification.
- ###### There is an AI performance tier classification for each metropolitan area.

- ###### Each metropolitan area has AI-related job postings. 
- ###### There are AI-related job postings for each metropolitan area.

- ###### VC activity (e.g. vc deals and respective deal amounts, companies involved, etc.) is recorded for each state. 
- ###### Each state records VC activity.

#### Sample User Tasks
###### 1. Add a newly-constructed data center and respective utility use measures to the database.
###### 2. Remove an out-of-service data center and respective utility measures from the database.
###### 3. Update the water consumption measure for the state of Virginia for the year 2023.
###### 4. Join tables to view which metropolitan area and state each AI job is in.
###### 5. View each state's electricity consumption total for 2023.
###### 6. View the top three states with the highest water consumption, in order from highest to lowest.
###### 7. Group metropolitan areas by performance tier.
###### 8. Create a transaction inserting a new data center and all of its utility measures in a single operation.
###### 9. Create a trigger so that every time a new VC funding record is inserted into state_vc_activity, it automatically writes a copy to vc_activity_log with a timestamp (essentially creating an audit log to view when records were added and in what order).
###### 10. Calculate the average electricity consumption across data centers and return the facilities that exceed that average.
