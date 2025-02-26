// Define the module with an address (like a home for our code on the blockchain)
// Modules keep our code organised and reusable
#[allow(duplicate_alias)]
module coffee::coffee_shop {
    // Import Sui tools we need
    use sui::object; // Helps us create unique IDs for things
    use sui::tx_context; // Tracks transaction details 
    use sui::transfer; // Lets us send objects to other addresses 

    // Define a CoffeeType struct to represnt different coffees
    // `has copy, drop` means we can copy it and discard it easily (no blockchain storage)
    public struct CoffeeType has copy, drop {
        kind: u8 // To use a number to represent coffee type(0 = Americano, 1 = Espresso)
    }

    // Define a CoffeeSize struct for sizes
    public struct CoffeeSize has copy, drop {
        size: u8 // 0= Small , 1 = Medium, 2 = Large
    }

    // Define a Stock struct for coffee shop ingredients
    // `has key, store` means it can live on the blockchain and be stored or moved
    public struct Stock has key, store {
        id: object::UID, // Unique ID for this stock object
        milk: u64,  // Amount of milk in (ml)
        coffee_beans: u64, // Amount of coffee beans in (g)
        sugar: u64, // Amount of sugar in (g)
        
    }
}