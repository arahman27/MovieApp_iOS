//
//  MovieVC.swift
//  A3_Aditya_Rahman


import UIKit

class MovieVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var filterMovies: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var filteredMovies: [Movie]!
    
    var movies: [Movie] = [
        Movie(title: "The Shawshank Redemption", year: 1994, imdbID: "tt0111161", type: "Drama", poster: "https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_.jpg"),
        Movie(title: "The Godfather", year: 1972, imdbID: "tt0068646", type: "Crime, Drama", poster: "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg"),
        Movie(title: "The Dark Knight", year: 2008, imdbID: "tt0468569", type: "Action, Crime, Drama", poster: "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg"),
        Movie(title: "The Godfather Part II", year: 1974, imdbID: "tt0071562", type: "Crime, Drama", poster: "https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg"),
        Movie(title: "12 Angry Men", year: 1957, imdbID: "tt0050083", type: "Crime, Drama", poster: "https://upload.wikimedia.org/wikipedia/commons/b/b5/12_Angry_Men_%281957_film_poster%29.jpg"),
        Movie(title: "Schindler's List", year: 1993, imdbID: "tt0108052", type: "Biography, Drama, History", poster: "https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg"),
        Movie(title: "The Lord of the Rings: The Return of the King", year: 2003, imdbID: "tt0167260", type: "Action, Adventure, Drama", poster: "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg"),
        Movie(title: "Pulp Fiction", year: 1994, imdbID: "tt0110912", type: "Crime, Drama", poster: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg"),
        Movie(title: "The Lord of the Rings: The Fellowship of the Ring", year: 2001, imdbID: "tt0120737", type: "Action, Adventure, Drama", poster: "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg"),
        Movie(title: "The Good, the Bad and the Ugly", year: 1966, imdbID: "tt0060196", type: "Adventure, Western", poster: "https://m.media-amazon.com/images/M/MV5BNjJlYmNkZGItM2NhYy00MjlmLTk5NmQtNjg1NmM2ODU4OTMwXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_.jpg"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        filterMovies.delegate = self
        
        filteredMovies = movies
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        itemCell.textLabel?.text = filteredMovies[indexPath.row].title
        
        return itemCell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movies"
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var idx = 0
        
        for mov in movies {
            if mov.title == filteredMovies[indexPath.row].title{
                movies.remove(at: idx)
            }
            
            idx += 1
        }
        
        filteredMovies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailVC {
            vc.mov_title = filteredMovies[indexPath.row].title
            vc.mov_year = filteredMovies[indexPath.row].year
            vc.mov_id = filteredMovies[indexPath.row].imdbID
            vc.mov_type = filteredMovies[indexPath.row].type
            vc.mov_img = filteredMovies[indexPath.row].poster
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = []
        
        if searchText == "" {
            filteredMovies = movies
            
        }
        else{
            for mov in movies {
                if mov.title.lowercased().contains(searchText.lowercased()) {
                    filteredMovies.append(mov)
                    
                }
            }
        }
        
        self.moviesTableView.reloadData()
        
    }
    
    @IBAction func addMovie(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add movie", message: "Enter movie information", preferredStyle: .alert)
        alert.addTextField {textField in
            textField.placeholder = "Enter movie title"
            
        }
        alert.addTextField {textField in
            textField.placeholder = "Enter movie year"
        }
        alert.addTextField {textField in
            textField.placeholder = "Enter the imdbID of the movie"
        }
        alert.addTextField {textField in
            textField.placeholder = "Enter the movie's genre i.e, Action, Drama"
        }
        alert.addTextField {textField in
            textField.placeholder = "Enter the poster image url of the movie"
        }

        let action = UIAlertAction(title: "Add movie", style: .default) { _ in
            var movTitle = String()
            var movYear = Int(0)
            var movID = String()
            var movType = String()
            var movPoster = String()
            
            if alert.textFields?[0].text != ""{
                movTitle = alert.textFields?[0].text ?? ""
            }
            if alert.textFields?[0].text != ""{
                movYear = Int(alert.textFields?[1].text ?? "") ?? 0
            }
            if alert.textFields?[0].text != ""{
                movID = alert.textFields?[2].text ?? ""
            }
            if alert.textFields?[0].text != ""{
                movType = alert.textFields?[3].text ?? ""
            }
            if alert.textFields?[0].text != ""{
                movPoster = alert.textFields?[4].text ?? ""
            }
            
            if movTitle != "" && movYear != 0 && movID != "" && movType != "" && movPoster != "" {
                self.filteredMovies.append(Movie(title: movTitle, year: movYear, imdbID: movID, type: movType, poster: movPoster))
                self.movies.append(Movie(title: movTitle, year: movYear, imdbID: movID, type: movType, poster: movPoster))
                self.moviesTableView.beginUpdates()
                self.moviesTableView.insertRows(at: [(NSIndexPath(row: self.filteredMovies.count-1, section: 0) as IndexPath)], with: .automatic)
                self.moviesTableView.endUpdates()
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Invalid movie entry. Please try again.", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(dismissAlert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true, completion: nil)

    }
}
