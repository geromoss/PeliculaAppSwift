//
//  DetallePeliculaTableViewController.swift
//  Peliculas
//
//  Created by Gerardo Lupa on 7-03-18.
//  Copyright © 2018 Gerardo Lupa. All rights reserved.
//

import UIKit

class DetallePeliculaTableViewController: UITableViewController {
    
    var recibido = [String :AnyObject]()
    var recibido_titulo_Pelicula : String = ""
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SegundoController llego esto: \(recibido_titulo_Pelicula)")
        print("SegundoController llego este Diccionario: \(recibido)")
        print("Titlo de la pelicula \(recibido["original_title"]!)")
        //self.view.backgroundColor = UIColor.red

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = recibido.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        //return UIColor(red:0.40, green: color, blue:0.80, alpha:1.0)
       return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 6
        default:
            assert(false, "section \(section)")
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.backgroundColor = colorForIndex(index: indexPath.row)

        // Configure the cell...
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                //cargamos el url del poster de la pelicula
                let url_poster = recibido["poster_path"] as! String
                //concatenamos la url de ruta para el poster
                let ruta = "http://image.tmdb.org/t/p/w500"+url_poster
                //declaramos una variable de tipo NSData
                let foto_Data : NSData?
                //declaramos la url
                let poster = URL(string: ruta)
                //le deciamos que carga la imagen en la siguiente url
                foto_Data = NSData(contentsOf: poster!)
                
                if foto_Data != nil{
                  //  let newImgThumb = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
                   // newImgThumb.contentMode = .scaleAspectFit
                    
                   // cell.imageView?. = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
                   
                    cell.imageView?.image = UIImage(data: foto_Data! as Data)
                    cell.imageView?.layer.masksToBounds = true
                    cell.imageView?.layer.cornerRadius = 5.0
                    cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
                  
                }

                break
            case 1:
                cell.textLabel?.text = "Titulo: \(recibido["original_title"]!)"
                cell.textLabel?.textColor = UIColor.blue
                cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                
                
                break
            case 2:
                let formateador = NumberFormatter()
                formateador.maximumFractionDigits = 2
                let numero_redondeado = formateador.string(from: recibido["popularity"] as! NSNumber)
                cell.textLabel?.text = "Popularidad: \(numero_redondeado!)"
                break
            case 3:
                cell.textLabel?.text = "Fecha lanzamiento: \(recibido["release_date"]!)"
                break
            case 4:
                cell.textLabel?.text = "cantidad de Votos: \(recibido["vote_count"]!)"
                break
            case 5:
                cell.textLabel?.text = "Descripcion: \(recibido["overview"]!)"
                cell.textLabel?.numberOfLines = 0
                break
            default:
                fatalError("Desconocida Fila")
            }
            
        default:
            fatalError("Unknown section")
        }
  
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
