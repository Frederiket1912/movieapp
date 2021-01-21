class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    puts :show
    puts params[:id]
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit
    end
  end

  def search
    movie = find_movie(params[:title])

    unless movie
      flash[:alert] = 'Movie not found'
      return render action: :new
    end

    redirect_to action: :index
  end

  def find_movie(name)
    request_api(
      "http://www.omdbapi.com/?t=#{URI.encode(name)}&apikey=662d698e"
    )
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to root_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :release_year, :img_url, :genre, :runtime, :comment)
    end
  
  private
    def request_api(url)
      response = Excon.get(url)
      return nil if response.status != 200
      
      data = JSON.parse(response.body)
      title = data['Title']
      release_year = data['Year']
      img_url = data['Poster']
      genre = data['Genre']
      runtime = data['Runtime']
      
      movie = Movie.new(title: title, release_year: release_year, img_url: img_url, genre: genre, runtime: runtime)
      movie.save
    end
end
