# GCD & NSOperationQueue

# Design Pattern 
   MVVM with closure 
   
## Here we have covered multithreading with the help of GCD & NSoperation.

#### GCD 
      * fetch the images of pet we have used DispatchQueue with GroupDispatch
      * call sequence PetsListVC -> PetsListVM -> FetchImageRequestData -> NetworkManager
      * In NetworkManager class you can check method - private func fetchPetsImage(config: Configuration,completion: @escaping (_ imageData: [Data]) ->             Void? )
#### NSOperatio
     
     * To fetch the single image we have used NSoperation 
     * call sequence FetchImageVC -> FetchImageVM -> FetchImageRequestData -> NetworkManager
     * In NetworkManager class you can check method -  private func fetchSingleImage(config: Configuration, completion:@escaping (_ imageData: [Data]) -> Void?)
      
      
