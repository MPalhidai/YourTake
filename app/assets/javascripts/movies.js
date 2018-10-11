const BASEURL = "https://api.themoviedb.org/3/";
const KEY = "?api_key=b93dbe1063e7a3c72594bd72ccddee56";
const GENRE = "genre/movie/list";
const LANGUAGE = "&language=en-US";
const DISCOVER = "discover/movie" + KEY + LANGUAGE;
const GENRES = BASEURL + GENRE + KEY + LANGUAGE;
const MONTHS = {'01':'Jan','02':'Feb','03':'Mar','04':'Apr','05':'May','06':'Jun','07':'Jul','08':'Aug','09':'Sep','10':'Oct','11':'Nov','12':'Dec'};

// change all urls to dynamically generate from user dropdown menus
let moviePopularityURL = BASEURL + DISCOVER + "&sort_by=popularity.desc&include_adult=false&include_video=false&page=";
let movieReleaseURL = BASEURL + DISCOVER + "&sort_by=release_date.desc&include_adult=false&include_video=false&vote_count.gte=1&primary_release_year=2018&page=";
let movieTitleURL = BASEURL + DISCOVER + "&sort_by=original_title.asc&include_adult=false&include_video=false&vote_count.gte=1&page=";
let movieGenreURL = BASEURL + DISCOVER + "&sort_by=popularity.desc&include_adult=false&include_video=false&vote_count.gte=1&with_genres=28&page=";

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

    if (!movie.poster_path) return; // skip if missing poster for aesthetics. Could be an array of all used results and checked for all !undefined

    let movie_partials = document.querySelector('.movie_partials');

    let movie_card = document.createElement('div');
    movie_card.classList.add('movie_card', 'border', 'border-secondary', 'p-3', 'mb-3');

    let movie_card_top_row = document.createElement('div');
    movie_card_top_row.classList.add('row', 'justify-content-between');

    let movie_card_top_col_4 = document.createElement('div');
    movie_card_top_col_4.classList.add('col-4', 'text-center');

    let movie_card_cover = document.createElement('div');
    movie_card_cover.classList.add('movie_card_cover');

    let movie_card_cover_img = document.createElement('img');
    movie_card_cover_img.classList.add('movie_card_cover_img');
    movie_card_cover_img.src = `http://image.tmdb.org/t/p/w154//${movie.poster_path}`;

    let movie_card_top_col_8 = document.createElement('div');
    movie_card_top_col_8.classList.add('col-8');

    let movie_card_title = document.createElement('button');
    movie_card_title.classList.add('movie_card_title', 'btn', 'btn-link', 'p-0');
    movie_card_title.innerHTML = movie.title;

    let movieData = JSON.stringify({ "movie": { 'external_rating': movie.vote_average, 'external_id': movie.id, 'title': movie.title } });
    movie_card_title.addEventListener('click', () => {
      $.ajax({
        url: 'movies',
        type: 'POST',
        data: movieData,
        contentType: 'application/json'
      });
    });

    let movie_card_release_date = document.createElement('p');
    movie_card_release_date.classList.add('m-0');
    let date = movie.release_date.split('-');
    movie_card_release_date.innerHTML = `Release Date: ${MONTHS[date[1]]} ${date[2]}, ${date[0]}`;

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
    movie_card_rating_div.classList.add('movie_card_reviews');

    let movie_card_rating_div_hidden = document.createElement('div');
    movie_card_rating_div_hidden.classList.add('movie_card_reviews_hidden', 'd-none');

    settings.url = BASEURL + `movie/${movie.id}/reviews`+ KEY + LANGUAGE + `&page=1`;
    $.ajax(settings).done(function (api_movie_review_call) {

      for (let i = 0; i < api_movie_review_call.results.length; i++) {

        let movie_card_rating_stars = document.createElement('span');
        movie_card_rating_stars.classList.add('stars-container', 'stars-' + (movie.vote_average*10).toString());
        movie_card_rating_stars.innerHTML = '★★★★★';

        let movie_card_rating_partial = document.createElement('a');
        movie_card_rating_partial.classList.add('movie_card_rating', 'mb-0');
        movie_card_rating_partial.href = api_movie_review_call.results[i].url;

        let long_comment = api_movie_review_call.results[i].content;
        if (long_comment.length > 35) {
          let short_comment = long_comment.substring(0, 32) + "...";
          movie_card_rating_partial.innerHTML = ` ${short_comment} - ${api_movie_review_call.results[i].author}`;
        } else {
          movie_card_rating_partial.innerHTML = ` ${long_comment} - ${api_movie_review_call.results[i].author}`;
        }

        if (i < 2) {
          movie_card_rating_div.appendChild(movie_card_rating_stars);
          movie_card_rating_div.appendChild(movie_card_rating_partial);
          movie_card_rating_div.appendChild(document.createElement('br'));
        } else {
          movie_card_rating_div_hidden.appendChild(movie_card_rating_stars);
          movie_card_rating_div_hidden.appendChild(movie_card_rating_partial);
          movie_card_rating_div_hidden.appendChild(document.createElement('br'));
        }
      }
    });

    let movie_card_bot_row = document.createElement('div');
    movie_card_bot_row.classList.add('row', 'align-items-end');

    let movie_card_bot_col_4 = document.createElement('div');
    movie_card_bot_col_4.classList.add('col-4', 'movie_card_rating_avg', 'text-center');

    let movie_card_star_span = document.createElement('span');
    movie_card_star_span.classList.add('stars-container', 'bigger', 'stars-' + (movie.vote_average*10).toString());
    movie_card_star_span.innerHTML = '★★★★★';

    let movie_card_bot_col_8 = document.createElement('div');
    movie_card_bot_col_8.classList.add('col-8');



    // form
    let movie_card_form_hidden = document.createElement('form');
    movie_card_form_hidden.classList.add('movie_card_form_hidden', 'py-2', 'd-none', `form-${movie.id}`);
    // movie_card_form_hidden.name = 'review';
    // movie_card_form_hidden.action = 'reviews';
    // movie_card_form_hidden.method = 'post';
    let movie_card_form_rating_tag = document.createElement('p');
    movie_card_form_rating_tag.classList.add('movie_card_form_rating_tag');
    movie_card_form_rating_tag.innerHTML = 'Rating: (0-100)';
    let movie_card_form_rating = document.createElement('input');
    movie_card_form_rating.classList.add('movie_card_form_rating', 'mb-2');
    movie_card_form_rating.setAttribute("type", "number");
    movie_card_form_rating.min = 0;
    movie_card_form_rating.max = 100;
    movie_card_form_rating.placeholder = '100';
    movie_card_form_rating.name = 'rating';
    let movie_card_form_comment_tag = document.createElement('p');
    movie_card_form_comment_tag.classList.add('movie_card_form_comment_tag');
    movie_card_form_comment_tag.innerHTML = 'Comment: ';
    let movie_card_form_comment = document.createElement('textarea');
    movie_card_form_comment.classList.add('movie_card_form_comment', 'mb-2');
    movie_card_form_comment.rows = 4;
    movie_card_form_comment.cols = 50;
    movie_card_form_comment.name = 'comment';
    movie_card_form_comment.placeholder = `${movie.title} was awesome!!!`;
    let movie_card_form_movie_id = document.createElement('input');
    movie_card_form_movie_id.classList.add('movie_card_form_movie_id');
    movie_card_form_movie_id.setAttribute("type", "hidden");
    movie_card_form_movie_id.value = movie.id;
    movie_card_form_movie_id.name = 'external_id';
    let movie_card_form_submit = document.createElement('button');
    movie_card_form_submit.classList.add('movie_card_form_submit', 'btn', 'btn-outline-info');
    // movie_card_form_submit.setAttribute("type", "submit");
    movie_card_form_submit.innerHTML = "Submit";

    movie_card_form_submit.addEventListener('click', () => {
      let reviewData = getFormDataAsJSON(movie.id);
      $.ajax({
        url: 'reviews',
        type: 'POST',
        data: reviewData,
        contentType: 'application/json'
      });
    });
    // form



    let movie_card_view_more = document.createElement('button');
    movie_card_view_more.classList.add('movie_card_view_more', 'mr-3', 'p-0', 'btn', 'btn-link');
    movie_card_view_more.innerHTML = "View More";
    movie_card_view_more.addEventListener('click', () => {
      movie_card_rating_div_hidden.classList.remove('d-none');
    });
    // change this to be able to view less reviews with jQuery hasClass or remove the button if hidden div has no child nodes

    let movie_card_leave_review = document.createElement('button');
    movie_card_leave_review.classList.add('movie_card_leave_review', 'mr-3', 'p-0', 'btn', 'btn-link');
    movie_card_leave_review.innerHTML = "Leave A Review";
    movie_card_leave_review.addEventListener('click', () => {
      movie_card_form_hidden.classList.remove('d-none');
    });

    movie_card_cover.appendChild(movie_card_cover_img);

    movie_card_top_col_4.appendChild(movie_card_cover);

    movie_card_top_col_8.appendChild(movie_card_title);
    movie_card_top_col_8.appendChild(movie_card_release_date);
    movie_card_top_col_8.appendChild(movie_card_genre);
    movie_card_top_col_8.appendChild(movie_card_rating_div);
    movie_card_top_col_8.appendChild(movie_card_rating_div_hidden);

    movie_card_bot_col_4.appendChild(movie_card_star_span);

    movie_card_bot_col_8.appendChild(movie_card_view_more);
    movie_card_bot_col_8.appendChild(movie_card_leave_review);

    // form
    movie_card_form_hidden.appendChild(movie_card_form_rating_tag);
    movie_card_form_hidden.appendChild(movie_card_form_rating);
    movie_card_form_hidden.appendChild(movie_card_form_comment_tag);
    movie_card_form_hidden.appendChild(movie_card_form_comment);
    movie_card_form_hidden.appendChild(movie_card_form_movie_id);
    movie_card_form_hidden.appendChild(document.createElement('br'));
    movie_card_form_hidden.appendChild(movie_card_form_submit);
    movie_card_bot_col_8.appendChild(movie_card_form_hidden);
    // form

    movie_card_top_row.appendChild(movie_card_top_col_4);
    movie_card_top_row.appendChild(movie_card_top_col_8);
    movie_card_bot_row.appendChild(movie_card_bot_col_4);
    movie_card_bot_row.appendChild(movie_card_bot_col_8);

    movie_card.appendChild(movie_card_top_row);
    movie_card.appendChild(movie_card_bot_row);

    movie_partials.appendChild(movie_card);
  });
}

function objectifyForm(formArray) {
  let returnArray = {};
  for (let i = 0; i < formArray.length; i++){
    returnArray[formArray[i]['name']] = formArray[i]['value'];
  }
  return returnArray;
}

function getFormDataAsJSON(id) {
  // { review: { rating: 100, comment: 'Great!', external_id: 11111 }}
  let obj = objectifyForm( $( `.form-${id}` ).serializeArray() );
  return JSON.stringify({ 'review': obj });
}

$('#movies').ready(function(){
  $.ajax(settings).done(function (api_genre_call) {
    api_genre_call.genres.forEach(function(genre) {
      genreList[genre.id] = genre.name;
    });
  });

  let page_max = 1;
  function* nextPage(page, url) {
    while (page <= page_max) {
      settings.url = url + page.toString();
      $.ajax(settings).done(function (api_movie_call) {
        page_max = api_movie_call.total_pages;
        renderMovies(api_movie_call);
      });
      yield page++;
    }
  }

  let pageUp = nextPage(1, moviePopularityURL);
  pageUp.next();

  function clearCards(div) {
    let myNode = document.querySelector(div);
    while (myNode.firstChild) {
      myNode.removeChild(myNode.firstChild);
    }
  }

  $('.moreMovies').on('click', function(){
    pageUp.next();
  });
  $('.title').on('click', function(){
    pageUp = nextPage(1, movieTitleURL);
    clearCards('.movie_partials');
    pageUp.next();
  });
  $('.releaseDate').on('click', function(){
    pageUp = nextPage(1, movieReleaseURL);
    clearCards('.movie_partials');
    pageUp.next();
  });
  $('.genre').on('click', function(){
    pageUp = nextPage(1, movieGenreURL);
    clearCards('.movie_partials');
    pageUp.next();
  });
});
