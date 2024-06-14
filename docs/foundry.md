# Foundry Tool 

Foundry is a great framework for implementing fuzzing tests in an easy way.

### Foundry implementation for Stateless Fuzzing

You write a normal unit test but add the parameters in the field where you want Foundry to send random data, like:

```js
function testIsAlwaysGetZeroFuzz(uint256 data) public {
        exercise.doStuff(data);
        assert(exercise.shouldAlwaysBeZero() == 0);
    }
```

### Foundry implementation for Statefull Fuzzing - Open / Unguided 

Import `StdInvariant` from `forge-std` and inherit it in our test contract.

```js
import {StdInvariant} from "forge-std/StdInvariant.sol";

// inherits the contract as well
contract MyContractTest is StdInvariant, Test {...}

```

Then, in the setup of your test contract, you need to tell Foundry which contract you'll be calling random functions on.

```js
function setUp() public {
        sfc = new StatefulFuzzCatches();
@>        targetContract(address(sfc));
    }
```

Start the function name as:

```js
function statefulFuzz_nameTest()
function invariant_nameTest()
```


### Foundry implementation for Statefull Fuzzing - Handler method/ Guided

You need to create two contracts: `Handler.t.sol` and `Invariant.t.sol`. The `Invariant.t.sol` follows a similar structure to what was shown before, with a few additional elements that I'll explain.

1. Crete  `Handler.t.sol `
   This contract acts as an intermediary for managing contract interactions during fuzz testing. The handler will guide Foundry and the Stateful Fuzzing Test Suite on how to interact with the contract appropriately. It essentially tells Foundry when to call functions while handling the restrictions to prevent reverts.

2. Create a `Invariant.t.sol`
   1. Start by importing the handler.
   2. Instead of fuzzing the actual contract, we'll fuzz the handler. This makes the process easier and more manageable.
   
3. Add `targetSelector`
    ```js
        bytes4[] memory selectors = new bytes4[](2);

        selectors[0] = handler.functionName1.selector;
        selectors[1] = handler.functionName2.selector;

        targetSelector(FuzzSelector({addr: address(handler), selectors : selectors}));
        targetContract(address(handler)); 
    ```
This instructs the contract that the selectors and the target address to be used are those outlined in the handler.

By following these steps, you'll set up a proper stateful fuzzing test in Foundry. The handler will guide the fuzzing process, making it easier to manage and ensuring that the functions are called correctly.

 ## Terminal output
 
- `runs` refers to the number of scenarios the fuzzer tested.
- `μ` (Greek letter mu) is the mean gas used across all fuzz runs
- `~` (tilde) is the median gas used across all fuzz runs
