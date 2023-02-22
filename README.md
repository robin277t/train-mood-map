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


