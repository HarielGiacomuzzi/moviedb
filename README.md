# moviedb

An iOS app listing the top movies and some details from them, we use the [MovieDB API](https://www.themoviedb.org/documentation/api)
to fetch movies images and details.

Some Screenshoots.

![alt Home View](https://github.com/HarielGiacomuzzi/moviedb/blob/master/screenshots/image1.png "Main View")
![alt Detail View](https://github.com/HarielGiacomuzzi/moviedb/blob/master/screenshots/image2.png "Detail View")


This project only needs Xcode, iOS 13.0 and cocoapods ( wich you may find intel about [here](https://cocoapods.org/about) )
It needs to be inserted the API Keys ( public and private ) on the environment variables.

Improovments: 
  - The design wasn't clear about the coloring of the rating view, So I've updated this coloring according to the rate of the movie.
  - There's the need of setting a skeleton to the views, but at this moment this was left behind.
  - There's a some work to be done in error handling at this moment.
  - The UI may receive some improovments on the future as well.
  - As I dindn't had time to finish the details of the implementation, I've used Cocoapods to speedup the coding of the image slider on the details scene.
  - Also as time didn't permit, I've removed the persons view from the details view.
  - Also didn't had time to work on the CI scripts, just variable configuration on app side.

Overall Architecture:
	The project uses several design patterns, some with a bit of adaptations, but the most relevant ones 
	are MVVM and Repository pattern.


Author: Hariel Giacomuzzi Dias
