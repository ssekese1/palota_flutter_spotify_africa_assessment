# Palota Spotify Africa Assessment

Palota assessment starter project | Palota Spotify Africa (Afro Category) Assessment

![Palota Logo](https://palota.co.za/assets/images/meta/og-image.png)

## Getting Started

[Use this repo as a template](https://github.com/PalotaCompany/palota_flutter_spotify_africa_assessment/generate) or [fork this repo](https://github.com/PalotaCompany/palota_flutter_spotify_africa_assessment/fork) into your own Github account so you can make changes. Alternatively, you can clone the project and upload it to your own repo so it does not show the link back to this repo.

## The assessment

### Overview
This is a starter project for a simple music playlist viewing application. The main is to complete two primary pages. The first page will show a paginated (via infinite scroll) list of playlist information in a category and provide a click-through navigation to the second page. The second page will be show detailed information about a playlist including a list of all tracks in the specified playlst. 

There are some existing pages, e.g. the landing page [(landing.dart)](lib/features/landing/presentation/pages/landing.dart) and about page [(about.dart)](lib/features/about/presentation/pages/about.dart), you can leave those pages as they are.

### Data Source
The data will come from a custom RESTful API that serves music category and playlist data based on Spotify Data.

#### Authentication
An API key will be sent will be sent to you separately. The `apiKey` should be sent as a header with name `x-functions-key`. E.g:
```bash
curl --location --request GET 'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro' \
--header 'x-functions-key: {apiKey}'
```

#### Available Endpoints

The base URL for all calls is: https://palota-jobs-africa-spotify-fa.azurewebsites.net/api

| Description | Method | Route | Comments |
|:---:|:---:|:---:|---|
| Get single category | `GET` | browse/categories/{categoryId} | Spotify Documentation https://developer.spotify.com/documentation/web-api/reference/#endpoint-get-a-category  *N.B.: The only supported category id is `afro`* |
| List paginated playlist summaries | `GET` | browse/categories/{categoryId}/playlists | Spotify Documentation https://developer.spotify.com/documentation/web-api/reference/#endpoint-get-a-categories-playlists  *N.B.: The only query parameters supported are `offset` and `limit`. These help with pagination.  Hint: Not all results can be returned at once by API* |
| Get single playlist | `GET` | playlists/{playlistId} | Spotify Documentation https://developer.spotify.com/documentation/web-api/reference/#endpoint-get-playlist |
| Get single artist | `GET` | artists/{artistId} | Spotify Documentation https://developer.spotify.com/documentation/web-api/reference/#endpoint-get-an-artist |


### Required Tasks
1. Integrate to the Palota Spotify Africa API to retrieve specific data in the `afro` category of Spotify.
2. Complete the spotify category page ([`spotify_category.dart`](lib/features/spotify/presentation/pages/spotify_category.dart)) and integrate it to the API
3. Create click-through navigation to the plylist page (hint: consider using the [route generator](lib/routes.dart))
4. Complete the spotify playlist page ([`spotify_playlist.dart`](lib/features/spotify/presentation/pages/spotify_playlist.dart)) and integrate it to the API
5. Write clean code

### Bonus Tasks
1. Provider client-side search/filter capability to filter the list of tracks based on user input. You can put the search/filter input on the app bar of the playlist page.
2. List of unique artists within a playlist ordered by number of tracks they appear in.
3. Usage of a pattern that enforces clean code.


### Detailed designs
The detailed designs can be found [here](https://xd.adobe.com/view/197ee382-2119-4579-9d4a-e47832352c14-4c2d/): 


Look at the API to figure out where to get the values to populate.

N.B. The designs repeat some values as they are just for illustration. In your completed app, use the data from the API as is.

![animation](https://user-images.githubusercontent.com/4819593/127193095-4bcd3413-7bc1-478f-9016-3db7ab1cfe75.gif)

*N.B.: The data in the designs is not accurate or complete*


## Submission
Once done with the tasks, commit all your code and push it to your forked remote github repository. Submit a link to your forked repo (with relevant branch - ideally master) to the email which will be provided to you separately when the assessment is assigned to you. 

**Important: Make sure your app compiles and runs before submitting**

---


For help getting started with Flutter, view the
[flutter online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference. 
