module Backend exposing(..)
import Models exposing(Movie, Preferences)
import List exposing (all,any,length,map)
import String exposing (words)

--Genero = "Horror" || "Action"

-- **************
-- Requerimiento: filtrar películas por su título a medida que se escribe en el buscador;
-- **************

filtrarPeliculasPorPalabrasClave : String -> List Movie -> List Movie
filtrarPeliculasPorPalabrasClave palabras = List.filter (peliculaTienePalabrasClave palabras)

peliculaTienePalabrasClave : String -> Movie -> Bool
peliculaTienePalabrasClave palabras pelicula = List.all (flip contiene1palabra pelicula.title) (String.words palabras)

contiene1palabra : String -> String -> Bool
contiene1palabra palabra1 palabra2 =  String.contains (String.toUpper palabra1) (String.toUpper palabra2) && palabra1 /= "" && palabra2 /= ""

-- **************
-- Requerimiento: visualizar las películas según el género elegido en un selector;
-- **************

filtrarPeliculasPorGenero : String -> List Movie -> List Movie
filtrarPeliculasPorGenero genero = List.filter (coincideGenero genero)

coincideGenero : String -> Movie -> Bool
coincideGenero genero pelicula = List.any (contiene1palabra genero) (pelicula.genre)

-- **************
-- Requerimiento: filtrar las películas que sean aptas para menores de edad,
--                usando un checkbox;
-- **************

filtrarPeliculasPorMenoresDeEdad : Bool -> List Movie -> List Movie
filtrarPeliculasPorMenoresDeEdad mostrarSoloMenores peliculas = if mostrarSoloMenores then soloMenores peliculas else peliculas

soloMenores : List Movie -> List Movie
soloMenores = List.filter .forKids

-- **************
-- Requerimiento: ordenar las películas por su rating;
-- **************

ordenarPeliculasPorRating : List Movie -> List Movie
ordenarPeliculasPorRating = List.sortBy .matchPercentage

-- **************
-- Requerimiento: dar like a una película
-- **************

darLikeAPelicula : Int -> List Movie -> List Movie
darLikeAPelicula id = map (dar1Like id)

dar1Like : Int -> Movie -> Movie
dar1Like id pelicula = if (id == pelicula.id) then {pelicula | likes = pelicula.likes + 1} else pelicula

-- **************
-- Requerimiento: cargar preferencias a través de un popup modal,
--                calcular índice de coincidencia de cada película y
--                mostrarlo junto a la misma;
-- **************

calcularPorcentajeDeCoincidencia : Preferences -> List Movie -> List Movie
calcularPorcentajeDeCoincidencia preferencias = List.map (modificarPorcentaje preferencias)

modificarPorcentaje : Preferences -> Movie -> Movie
modificarPorcentaje preferencias pelicula = {pelicula | matchPercentage = porcentajeDe1Pelicula preferencias pelicula}

porcentajeDe1Pelicula : Preferences -> Movie -> Int
porcentajeDe1Pelicula preferencias pelicula = if (porcentajeTotal preferencias pelicula) > 100 then 100 else (porcentajeTotal preferencias pelicula)

porcentajeTotal : Preferences -> Movie -> Int
porcentajeTotal preferencias pelicula = (porcentajePalabrasClaves preferencias pelicula) + (porcentajeActor preferencias pelicula) + (porcentajeGenero preferencias pelicula) + (porcentajeGenerosAsociados preferencias pelicula)

--Porcentaje Palabras Claves
porcentajePalabrasClaves : Preferences -> Movie -> Int
porcentajePalabrasClaves preferencias = (*) 20<<List.length<<palabrasClavesEncontradas preferencias

palabrasClavesEncontradas : Preferences -> Movie -> List String
palabrasClavesEncontradas preferencias pelicula = List.filter (flip contiene1palabra  pelicula.title) (String.words preferencias.keywords)

--Porcentaje Actor
porcentajeActor : Preferences -> Movie -> Int
porcentajeActor preferencias pelicula = if contieneActor pelicula preferencias.favoriteActor then 50 else 0

contieneActor : Movie -> String -> Bool
contieneActor pelicula actor = any (contiene1palabra actor) pelicula.actors

--Porcentaje Genero
porcentajeGenero : Preferences -> Movie -> Int
porcentajeGenero preferencias pelicula = if (coincideGenero preferencias.genre pelicula) then 60 else 0

--Porcentaje Generos Asociados
porcentajeGenerosAsociados : Preferences -> Movie -> Int
porcentajeGenerosAsociados preferencias pelicula = lePuedeGustar preferencias.genre pelicula.genre

lePuedeGustar : String -> List String -> Int
lePuedeGustar genero = List.sum<<List.map (porcentajeAsociado genero)

porcentajeAsociado : String -> String -> Int
porcentajeAsociado genero posibleGenero = 
    case genero of
        "Superhero" -> if List.member posibleGenero ["Adventure", "Action", "War"] then 15 else 0
        "Adventure" -> if List.member posibleGenero ["Superhero", "Action", "War"] then 15 else 0
        "Action" -> if List.member posibleGenero ["Superhero", "Adventure", "War"] then 15 else 0
        "War" -> if List.member posibleGenero ["Adventure", "Action", "Superhero"] then 15 else 0
        "Comedy" -> if List.member posibleGenero ["Family", "Animated", "Fantasy"] then 15 else 0
        "Family" -> if List.member posibleGenero ["Comedy", "Animated", "Fantasy"] then 15 else 0
        "Animated" -> if List.member posibleGenero ["Family", "Comedy", "Fantasy"] then 15 else 0
        "Fantasy" -> if List.member posibleGenero ["Family", "Comedy", "Animated"] then 15 else 0
        "Horror" -> if posibleGenero == "Suspense" then 15 else 0
        "Suspense" -> if posibleGenero == "Horror" then 15 else 0
        _ -> 0

{-porcentajeAsociado genero posibleGenero = if esGeneroAsociado genero posibleGenero then 15 else 0 

esGeneroAsociado genero posibleGenero = 
    case genero of
        "Horror"-> 15
        _ -> 0-}