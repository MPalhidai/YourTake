const BASEURL = "https://api.themoviedb.org/3/";
const KEY = "?api_key=b93dbe1063e7a3c72594bd72ccddee56";
const DISCOVER = "discover/movie";
const GENRE = "genre/movie/list";
const LANGUAGE = "&language=en-US";
let movieIndexURL = BASEURL + DISCOVER + KEY + LANGUAGE + "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
const GENRES = BASEURL + GENRE + KEY + LANGUAGE;
let genreList = {};

let settings = {
  async: true,
  crossDomain: true,
  url: GENRES,
  method: "GET",
  headers: {},
  data: "{}"
};

const renderMovies = (movies) => {
  movies.results.forEach(function (movie) {
    let movie_partials = document.querySelector('.movie_partials');
    let movie_card = document.createElement('div');
    movie_card.classList.add('movie_card', 'border', 'border-secondary', 'p-3', 'mb-3');
    //top row
    let movie_card_top_row = document.createElement('div');
    movie_card_top_row.classList.add('row', 'justify-content-between');
    //top left
    let movie_card_top_col_4 = document.createElement('div');
    movie_card_top_col_4.classList.add('col-4', 'text-center');
    let movie_card_cover = document.createElement('div');
    movie_card_cover.classList.add('movie_card_cover');
    let movie_card_cover_img = document.createElement('img');
    movie_card_cover_img.classList.add('movie_card_cover_img');
    movie_card_cover_img.src = `http://image.tmdb.org/t/p/w154//${movie.poster_path}`;
    //top right
    let movie_card_top_col_8 = document.createElement('div');
    movie_card_top_col_8.classList.add('col-8', 'p-0');
    let movie_card_title = document.createElement('h3');
    movie_card_title.classList.add('movie_card_title');
    movie_card_title.innerHTML = movie.title;
    let movie_card_release_date = document.createElement('p');
    movie_card_release_date.classList.add('m-0');
    movie_card_release_date.innerHTML = `Release Date:  ${movie.release_date}`;
    let movie_card_genre = document.createElement('p');
    movie_card_genre.classList.add('mb-2');
    movie_card_genre.innerHTML = 'Genre: ';
    for (let i = 0; i < movie.genre_ids.length; i++) {
      if (i != movie.genre_ids.length - 1) {
        movie_card_genre.innerHTML += `${genreList[movie.genre_ids[i]]}, `;
      } else {
        movie_card_genre.innerHTML += `${genreList[movie.genre_ids[i]]}`;
      }
    };
    let movie_card_rating_div = document.createElement('div');
    movie_card_rating_div.classList.add('movie_card_reviews', 'mb-2');
    let movie_card_rating_1 = document.createElement('p');
    movie_card_rating_1.classList.add('movie_card_rating', 'mb-0');
    movie_card_rating_1.innerHTML = "Stars This movie is great! - critic";
    // CHANGE ABOVE ajax call on movie id to get newest reviews
    let movie_card_rating_2 = document.createElement('p');
    movie_card_rating_2.classList.add('movie_card_rating', 'mb-0');
    movie_card_rating_2.innerHTML = "Stars This movie is great! - critic";
    // CHANGE ABOVE ajax call on movie id to get newest reviews

    // bottom row
    let movie_card_bot_row = document.createElement('div');
    movie_card_bot_row.classList.add('row', 'align-items-end');
    // bot col left
    let movie_card_bot_col_4 = document.createElement('div');
    movie_card_bot_col_4.classList.add('col-4', 'movie_card_rating_avg', 'text-center');
    let movie_card_star_span = document.createElement('span');
    movie_card_star_span.innerHTML = movie.vote_average; // change this into stars
    // bot col right
    let movie_card_bot_col_8 = document.createElement('div');
    movie_card_bot_col_8.classList.add('col-8', 'p-0');
    let movie_card_view_more = document.createElement('a');
    movie_card_view_more.classList.add('movie_card_view_more', 'mr-2');
    movie_card_view_more.innerHTML = "View More";
    // CHANGE ABOVE movie_card_view_more.href = movie/show;
    let movie_card_leave_review = document.createElement('a');
    movie_card_leave_review.classList.add('movie_card_leave_review', 'mx-2');
    movie_card_leave_review.innerHTML = "Leave A Review";
    // CHANGE ABOVE movie_card_leave_review.href = movie/review; possibly open review form modal

    movie_card_cover.appendChild(movie_card_cover_img);

    movie_card_rating_div.appendChild(movie_card_rating_1);
    movie_card_rating_div.appendChild(movie_card_rating_2);

    movie_card_top_col_4.appendChild(movie_card_cover);

    movie_card_top_col_8.appendChild(movie_card_title);
    movie_card_top_col_8.appendChild(movie_card_release_date);
    movie_card_top_col_8.appendChild(movie_card_genre);
    movie_card_top_col_8.appendChild(movie_card_rating_div);

    movie_card_bot_col_4.appendChild(movie_card_star_span);

    movie_card_bot_col_8.appendChild(movie_card_view_more);
    movie_card_bot_col_8.appendChild(movie_card_leave_review);

    movie_card_top_row.appendChild(movie_card_top_col_4);
    movie_card_top_row.appendChild(movie_card_top_col_8);
    movie_card_bot_row.appendChild(movie_card_bot_col_4);
    movie_card_bot_row.appendChild(movie_card_bot_col_8);

    movie_card.appendChild(movie_card_top_row);
    movie_card.appendChild(movie_card_bot_row);

    movie_partials.appendChild(movie_card);
  });
}

$(document).ready(function(){
  $.ajax(settings).done(function (api_genre_call) {
    api_genre_call.genres.forEach(function(genre) {
      genreList[genre.id] = genre.name
    });
    console.log(genreList);
  });

  settings.url = movieIndexURL;
  $.ajax(settings).done(function (api_movie_call) {
    renderMovies(api_movie_call);
    console.log(api_movie_call);
  });
  $('.title').on('click', function(){
    // front end filter and sort
  });
  $('.releaseDate').on('click', function(){
    // front end filter and sort
  });
  $('.genre').on('click', function(){
    // front end filter and sort
  });
});
