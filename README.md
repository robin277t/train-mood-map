# Train Mood Map

## The requirements:

As a User
So I can know if a train I'm going to take is likely to be delayed
I want to be able to see a map of trains in my area and visually understand if there is general lateness affecting the line(s)

As a User
So I can know in advance I'm going to be running late
I want to be notified if it looks likely that there's lateness on the line

As a User
So I can make intelligent commuting decisions
I want to be able to set a threshold of lateness on trains in my area for triggering a notification to me

As a User
So I can understand the general performace of trains in my area
I want to see long term statistics on lateness and compare that across different areas


## The premise:

Train lateness and cancellation often seems to be available only at the last minute, and only for a specific train.
However, it is quite often possible to predict ahead of time that trains are likely to be late or cancelled based on activity that's occurring on the line, or at stations in the area.
For example, if all trains running through a station in the previous hour have run late, there's a strong chance your next train will too, so it would be good to know an hour in advance.
The idea behind this project is to develop an application that makes train commuting life smoother, using Network Rail API for live train data and timetables.
Additionally there will be a notification option, which can be set according to different parameters you find to be most pertinent based on your knowledge of your commute.
A stretch goal of the project will be to save and record some kind of score, which you can then use to compare areas for reliability (say if you were looking to move house)
Specific skills learned here; Mapping, high volume API data calls, Visualising large amounts of data to make it interpretable. Plan is to make this a deployed web app, possibly also to deploy as an android mobile app (for simpler notifications setup)

## Data sources

https://opendata.nationalrail.co.uk/feeds - Requires sign-up/log in credentials

The relevant feed is called DARWIN PUSH PORT. Documentation on it can be found here: https://wiki.openraildata.com/Darwin:Push_Port

Developer community and support here https://groups.google.com/g/openraildata-talk

Background data for the app will be OpenStreetMap https://www.openstreetmap.org for the basemap.

Could also look into if MapBox do anything nice for free?

Network rail train track layer for an additional overlay  https://github.com/openraildata/network-rail-gis

Other code for using this data: https://github.com/openraildata/

This seems to be a close example of what you want: https://www.map.signalbox.io/ but this actually uses (anonymised) mobile device location data which matches to the likeliest train they're on and then proceeds to match to Darwin feed data and show a moving spot on the map. Pretty cool.

## Design of the app

Basically a map. With zoom, and data only appears at a certain level of zoom. 

To show the mood, either the line segment and stations can be coloured (like on google maps traffic layer) or little dots that are trains can be present with colour. 

- With the line colouring methods, I'd need a way of matching the train data feed to the line segment. This will likely take the form of signal berth points and stations (the only places we have time estimates for) being mapped to each geospatial line segment. Each line segment and station would contain a database record of trains that have gone through it, and how on time or delayed (or cancelled) they were. We can also add records of forecast train times through the station in the next 30 to 60 minutes (or however far in the future they go). This would allow viewing of general colour based on recent past behaviour and forecast near future behaviour. Remaining question is whether a 'line' should be coloured based on all trains going through, or just the ones on that actual route. Eg Surbiton, coloured for Southampton trains when local Hampton Court service is working fine? This might depend on how the data comes from Darwin, if it's 1 berth across whole line fast and slow, then that'll be how it works, if seperate, then I've got options.

Required- to check: Geospatial line segments; their ID's and a list of the berths/stations on each one that match up to Darwin, and Darwin outputs a time through or predicted for each berth/station that is usable. Anything after that is just data handling and presentation.


- With the dot method, I'd need a lat/lon from the feed, or an inferred one from line data + progress between stations or nodes on the line. There's no lat/lon, and inferred location would be both potentially inaccurate and complicated to code. If the dot is to move, I'd again need to match it to the line if was moving on and know a progress estimate. So dots will form a part 2 to this project, and may not be that helpful but we'll see.

Extra bonus: default upon opening the site / app would be location data provided by your internet connection. You can also set a default, similar to how the metoffice app works.

If I get to the stretch goals, historical data would also work on a colour coded geospatial domain, with a train matching to its nearest timetabled buddy, or just have the line segment coloured, so you get an idea of line reliability.

## Development Process

- *This project will enable me to learn several things;*
- Huge data dump handling from live feed 
- Geospatial data and mapping
- More complex database queries
- Ruby on Rails
- Make a good looking interactive frontend
- Deploy a live site and server with large database
- Entering into a relatively poorly documented open source data world

1. Figure out live train data

2. Do a tutorial on how to use mapping/geospatial data in a web app; tiles/tiling zoom, gpx tracks, lat/lon to line matching

3. Do a tutorial on Ruby on Rails to build the project scaffold

MVP is one piece of train track or one train with a basic colour coding for one area (one tile of a map), with a local frontend and local server made using react and rails with Postgres (or if there is a better frontend package for mapping than react then use that).

Next is to add features as seems most logical.




