#[starknet::interface]
trait IAddMyFelts<TContractState> {
    fn get_x(self: @TContractState) -> felt252;
    fn get_y(self: @TContractState) -> felt252;
    fn add_my_felts_baby(self: @TContractState) -> felt252;
    fn set_x(ref self: TContractState, numerator: felt252);
    fn set_y(ref self: TContractState, denominator: felt252);
}

#[starknet::contract]
mod AddMyFelts {
    use starknet::{ ContractAddress, get_caller_address };
    use zeroable::IsZeroResult;

    #[storage]
    struct Storage {
        x: felt252,
        y: felt252
    }

    #[constructor]
    fn constructor(ref self: ContractState, x: felt252, y: felt252) {
        self.x.write(x);
        self.y.write(y);
    }
    
//    #[generate_trait]
//    impl InternalFunctions of InternalFunctionsTrait {
//        // Implementation of the internal functions
//        fn _felt_to_nonzero(value: felt252) -> NonZero<felt252> {
//            match felt252_is_zero(value) {
//                IsZeroResult::Zero(()) => panic(array!['Nope, can\'t divide by zero!']),
//                IsZeroResult::NonZero(x) => x,
//            }
//        }
//    }
    
    #[external(v0)]
    impl AddMyFeltsImpl of super::IAddMyFelts<ContractState> {
        fn get_x(self: @ContractState) -> felt252 {
            self.x.read()
        }
        fn get_y(self: @ContractState) -> felt252 {
            self.y.read()
        }
        fn add_my_felts_baby(self: @ContractState) -> felt252 {
            self.x.read() + self.y.read()
        }
        fn set_x(ref self: ContractState, x: felt252) {
            self.x.write(x);
        }
        fn set_y(ref self: ContractState, y: felt252) {
            self.y.write(y);
        }
    }
}