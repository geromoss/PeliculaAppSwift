//
//  ViewController.swift
//  Peliculas
//
//  Created by Gerardo Lupa on 07-03-2019.
//  Copyright © 2018 Gerardo Lupa. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mi_tabla: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //recibe las peliculas
    var peliculas = [AnyObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicator = UIActivityIndicatorView(style: .gray) // creamos un indicador de actividad un spinner
        view.addSubview(activityIndicator) // lo agregamos como subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // colocamos el spinner en el centro de la pantalla
        activityIndicator.startAnimating() // empieza a girar (animar)
        
        //cargamos los datos de JSON alamoFire
        Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44").validate(statusCode: 200..<600).responseJSON { response in
            
            activityIndicator.stopAnimating() // paramos la animacion del spiner
            activityIndicator.removeFromSuperview() // sacamos la el rueda de la vista
            
            switch response.result{
                
            case .success:
                if let diccionario = response.value as? Dictionary<String,Any>{
                    
                    if let inneDic = diccionario["results"]{
                       //traspasamos los datos al diccionario
                        self.peliculas = inneDic as! [AnyObject]
                        print("Mostrando peliculas \(self.peliculas)")
                        //hacemos un reaload a la tabla para que muestre los datos
                        self.mi_tabla.reloadData()
                    }
                }
                
            case .failure(let error):
                print("error del JSON: \(error)")
            }
            
        }
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.peliculas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.mi_tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomUITableViewCell
        
        //aqui cargamos los datos que tienen del Array
        cell.NombrePelicula.text = peliculas[indexPath.row]["original_title"] as? String
        cell.EstrenoPelicula.text = peliculas[indexPath.row]["release_date"] as? String
        let promedio_votos = peliculas[indexPath.row]["vote_average"] as! Double
        cell.PromedioPelicula.text = "Promedio Votos: "+String(promedio_votos)
        //cargamos el poster de la pelicula
        let poster = peliculas[indexPath.row]["poster_path"] as? String
        //incluimos la varaible de la ruta
        let URLruta = "http://image.tmdb.org/t/p/w500"+poster!
        //declaramos la variable de tipo NSdata para convertir la URL en imagen
        var miData: NSData?
        //declaramos de donde viene la URL
        let miURL = URL(string: URLruta)
        //le decimos que carga la imagen en la siguiente ruta
        miData = NSData(contentsOf: miURL!)
        
        if miData != nil{
            //si hay poster entonces cargamos la imagen en la tabla
            cell.PosterPelicula.image = UIImage(data: miData! as Data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
/*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("tu has seleccionado: \(peliculas[indexPath.row])")
        //self.performSegue(withIdentifier: "Detalle", sender: self)
    }
    */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if (segue.identifier == "Detalle"){
    
            if let Elindexpath = self.mi_tabla.indexPathForSelectedRow{
                let destino = segue.destination as! DetallePeliculaTableViewController
                //le pasamos los datos
                //destino.recibido = peliculas[Elindexpath.row] as! [AnyObject]
                destino.recibido_titulo_Pelicula = peliculas[Elindexpath.row]["original_title"] as! String
                //print("Enviando Datos \(destino.recibido_titulo_Pelicula)")
                destino.recibido = peliculas[Elindexpath.row] as! [String: AnyObject]
                //print("enviando Dictionario: \(destino.recibido)")
            }
        }
     }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            view.addSubview(activityIndicator) // lo agregamos como subvista el spiner girando
            activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // lo colocamos en el centro
            activityIndicator.startAnimating() // empieza a animar el spinner
            
            print("presionaste el Popular se carga datos del pòpular")
            Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44").validate(statusCode: 200..<600).responseJSON{ response in
                activityIndicator.stopAnimating() // detenemos la animacion
                activityIndicator.removeFromSuperview() // sacamos el spiner de la vista
                switch response.result{
                case .success:
                    if let diccionarioPopular = response.value as? Dictionary<String, Any>{
                        if let inneDicPopular = diccionarioPopular["results"]{
                            //traspasamos los datos al diccionario
                            self.peliculas = inneDicPopular as! [AnyObject]
                            print("Monstrando peliculas Populares \(self.peliculas)")
                            //hacemos un reload a la table para que muestre los datos
                            self.mi_tabla.reloadData()
                        }
                    }
                case .failure(let error):
                    print("error del JSON: \(error)")
                }
            }
        case 1:
            print("presionaste el Top de peliculas")
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            view.addSubview(activityIndicator) // lo mismo agregamos como subvista
            activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // lo colocamos en el centro de la pantalla
            activityIndicator.startAnimating() // empezamos a animar la vista
            
            Alamofire.request("https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44").validate(statusCode: 200..<600).responseJSON{ response in
                activityIndicator.stopAnimating() // detenemos la animacion girando
                activityIndicator.removeFromSuperview() // sacamos el spiner de la vista
                
                switch response.result{
                case .success:
                    if let diccionarioTop = response.value as? Dictionary<String,Any>{
                        
                        if let inneDicTop = diccionarioTop["results"]{
                            //traspasamos los datos al diccionario
                            self.peliculas = inneDicTop as! [AnyObject]
                            print("Mostrando Top peliculas \(self.peliculas)")
                            //hacemos un reaload a la tabla para que muestre los datos
                            self.mi_tabla.reloadData()
                        }
                    }
                    
                case .failure(let error):
                    print("error del JSON: \(error)")
                    
                }
            }
        default:
            break
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

