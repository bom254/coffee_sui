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
        hot_water: u64  // AMount of hot water in (ml)
    }

    // Define an Order struct for a customer's coffee order
    // `has copy, drop` since it's just data we pass around
    public struct Order has copy, drop {
        coffee_type: CoffeeType, // What kind of coffee they want
        size: CoffeeSize // What size they want
    }

    // Helper function to create CoffeeType 
    public fun new_coffee_type(kind: u8): CoffeeType {
        CoffeeType{
            kind
        }  // Returns a CoffeeType with the given number
    }

    // Helper function to create CoffeeSize
    public fun new_coffee_size(size: u8): CoffeeSize {
        CoffeeSize{
            size
        }
    }

    // Function to calculate the price of a coffee based on type and size
    public fun calculate_price(coffee: &CoffeeType, size: &CoffeeSize): u64 {
        // Set a base prce depending on coffee type
        let base_price: u64 = if(coffee.kind == 0) {
                                   30
                                } // Americano
                                else if (coffee.kind == 1) {
                                    40
                                } // Espresso
                                else if (coffee.kind == 2) {
                                    20
                                } // Latte
                                else if (coffee.kind == 3) {
                                    25
                                } // Cappuccino
                                else {
                                    0
                                }; // Invalid type

        // Extra cost based on size
        let size_price: u64 = if (size.size == 0) {
                                5
                              } // Small
                              else if (size.size == 1) {
                                7
                              } // Medium
                              else if (size.size == 2) {
                                9
                              } // Large
                              else {
                                0
                              }; // Invalid size

        base_price + size_price // Total price cost
    }
        // Function to check if we have enough ingredients for a coffee
    public fun in_stcok(coffee: &CoffeeType, stock: &Stock): bool {
        // Get the stock amounts
        let beans = stock.coffee_beans;
        let milk = stock.milk;
        let sugar = stock.sugar;
        let water = stock.hot_water;

        // Check based on coffee type 
        if(coffee.kind == 0) { // Americano: 25g beans, 15g sugar, 50ml water
            beans >= 25 && sugar >= 15 && water >=50
        } else if (coffee.kind == 1) { // Espresso : 20g beans, 50ml milk, 15g sugar, 50ml water
            beans >= 20 && milk >=50 && sugar >=15 && water >=50
        } else if (coffee.kind)
    }
}