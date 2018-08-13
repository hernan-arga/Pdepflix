module Models exposing (..)

type alias Movie = {
  id: Int,
  poster : Image,
  title: String,
  rating: Float,
  genre: List String,
  link: String,
  likes: Int,
  matchPercentage: Int,
  forKids: Bool,
  actors : List String
}

type alias Image = {
  url : String,
  width : Int,
  height : Int
}

type alias Preferences = {
  keywords: String,
  genre: String,
  favoriteActor: String
}

type alias Model = {movies : List Movie, shouldShowDialog: Bool, preferences: Preferences, genre: String, kidsProtection: Bool}


--MOVIES
moviesCollection : List Movie
moviesCollection = [avengers2, toyStory3, lionKing, it, labyrinth, inglouriousBasterds, banieros3, jackAndJill, thePrincessDiaries, gaturro, lasNormas]

avengers2 : Movie
avengers2 = {id= 1, poster= createPoster "./Assets/Avengers_Age_Of_Ultron.png", title= "Avengers: Age of Ultron", rating= 8.3, genre= ["Action", "Adventure", "Superhero"], link= "https://www.youtube.com/watch?v=rD8lWtcgeyg", likes = 0, matchPercentage = 0, forKids = True, actors = ["Robert Downey JR", "Chris Hemsworth", "Mark Ruffalo", "Chris Evans", "Scarlett Johansson", "Samuel L. Jackson"]}

toyStory3 : Movie
toyStory3 = {id= 2, poster= createPoster "./Assets/Toy_Story_3_poster.png", title= "Toy Story 3", rating= 9.0, genre= ["Family", "Animated"], link= "https://www.youtube.com/watch?v=JcpWXaA2qeg", likes = 0, matchPercentage = 0, forKids = True, actors = ["Tom Hanks", "Tim Allen", "Don Rickles", "Wallace Shawn", "John Ratzenberger", "Ned Beatty", "Michael Keaton", "John Morris", "Blake Clark"]}

lionKing : Movie
lionKing = {id= 3, poster= createPoster "./Assets/The_Lion_King.png", title= "Lion King", rating= 9.5, genre= ["Family", "Animated"], link= "https://www.youtube.com/watch?v=_ujGv5dhGfk", likes = 0, matchPercentage = 0, forKids = True, actors = ["Rowan Atkinson", "Matthew Broderick", "Niketa Calame-Harris", "Jeremy Irons", "James Earl Jones", "Nathan Lane", "Ernie Sabella"]}

it : Movie
it = {id= 4, poster= createPoster "./Assets/it_poster.png", title= "IT", rating= 8.0, genre= ["Horror"], link= "https://www.youtube.com/watch?v=hAUTdjf9rko", likes = 0, matchPercentage = 0, forKids = False, actors = ["Jaeden Lieberher", "Bill Skarsgård", "Wyatt Oleff", "Jeremy Ray Taylor", "Sophia Lillis", "Finn Wolfhard"]}

labyrinth : Movie
labyrinth = {id= 5, poster = createPoster "./Assets/labyrinth.png", title= "Labyrinth", rating= 8.0, genre= ["Fantasy", "Musical", "Family"], link="https://www.youtube.com/watch?v=O2yd4em1I6M", likes = 0, matchPercentage = 0, forKids = True, actors = ["David Bowie", "Jennifer Connelly", "Toby Froud", "Brian Henson"]}

inglouriousBasterds : Movie
inglouriousBasterds = {id= 6, poster = createPoster "./Assets/inglorious_bastards.png", title= "Inglourious Basterds", rating= 9.0, genre= ["Action", "War", "Drama"], link= "https://www.youtube.com/watch?v=KnrRy6kSFF0", likes = 0, matchPercentage = 0, forKids = False, actors = ["Brad Pitt", "Christoph Waltz", "Diane Kruger", "Mélanie Laurent"]}

banieros3 : Movie
banieros3 = {id= 7, poster = createPoster "./Assets/banieros3.png", title= "Bañeros 3: Todopoderosos", rating= 10.0, genre= ["Comedy", "Action", "Drama"], link= "https://www.youtube.com/watch?v=K-fwBTo6nDs", likes = 0, matchPercentage = 0, forKids = False, actors = ["Emilio Disi", "Pablo Granados", "Pachu Peña", "Freddy Villarreal", "Gino Renni"]} 

jackAndJill : Movie
jackAndJill = {id= 8, poster = createPoster "./Assets/Jack_and_jill.png", title= "Jack and Jill", rating= 2.3, genre= ["Horror"], link= "https://www.youtube.com/watch?v=qHKTXrUnN58", likes = 0, matchPercentage = 0, forKids = False, actors = ["Adam Sandler"]}

thePrincessDiaries : Movie
thePrincessDiaries = {id=9, poster = createPoster "./Assets/ThePrincessDiaries.png", title= "El diario de la Princesa", rating= 10.0, genre=["Comedy"], link= "https://www.youtube.com/watch?v=2CkcwPi20ms", likes= 0, matchPercentage= 0, forKids= True, actors = ["Anne Hathaway","Julie Andrews"]}

gaturro : Movie
gaturro = {id=10, poster = createPoster "./Assets/Gaturro.png", title= "Gaturro", rating= 100000000000.0, genre=["Comedy","Family", "Animated"], link= "https://www.youtube.com/watch?v=FBlGmlLtSN0", likes= 999, matchPercentage= 0, forKids= True, actors = ["Gaturro"]}

lasNormas : Movie
lasNormas = {id=11, poster = createPoster "./Assets/Las normas de produccion.png", title= "Las normas de producción", rating= 10.0, genre=["Comedy","Family", "Animated"], link= "https://www.youtube.com/watch?v=Ax1svCIs4nI", likes= 1, matchPercentage= 0, forKids= True, actors = ["Deko","Mati","Abril","Hernan","Hernanda","Juan"]}


--POSTERS
createPoster : String -> Image
createPoster imageUrl = { url= imageUrl, width= 400, height= 400 }

initialModel : Model
initialModel = { movies = moviesCollection, shouldShowDialog = False, preferences = Preferences "" "" "", genre = "", kidsProtection = False }
