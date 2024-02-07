import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor Dbank {

  // stable keyword make the dat stored in the var persisted.
  stable var currentValue : Float = 300;

  // currentValue := 300;  //if we do like this than there is no use of persitence at evry time code runs is sets it to 100.
 
  let id = 1329293123;
  // Debug.print(debug_show(id));

  stable var startTime = Time.now();

  startTime := Time.now();

  Debug.print(debug_show(startTime));
 
  // public keyword is used to allow the usage of function outside the canister
  //  like cmd use the command -> dfx canister call <canister name> <function name> <arguments (if any)>
  public func topUp(amount : Float){
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };
  
  public func withdraw(amount : Float){
    let tempValue:Float = currentValue - amount;
    if(tempValue>=0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }
    else{
      Debug.print("Insufficient Balance.");
    }
  };
  
  public query func checkBalance() : async Float{
    return currentValue;
  };
  public func compound(){
    let currentTime=Time.now();
    let timeElapsedS = (currentTime-startTime)/(1000000000*10);
    currentValue := currentValue*(1.01**Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
  
  // orthogonal persistence
  // topUp();
};
