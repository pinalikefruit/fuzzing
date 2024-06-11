# Fuzzing Zone

Here you can find all important concepts, excersices, implementation, step-by-step increasing the level around Fuzzing.  

## What is Fuzzing ?

Fuzzing is a technique where the goals is to break the invariants of the contract, and this tecnhique try with invalid, unexpected and random data.

The beneficial is the contract is expose to extreme condition and help to find uncover hard-to-detect vulnerabilities. 

## What is an Invariant?

There are properties of our system that should be always hold true. 

E.g. Supply of tokens > the amount of token to mint 

Defining a good invariants is the key, is when you really understand and can explain in plain English what does the protocol and what doesn't. You can get the idea from whitepaper(abstracted), docs or solidity code base.

### Different types: 

1. Functional-level invariants: 
   1. They are stateless and can be tested in insolation. 
   2. Target specific element
2. System-level invariants:
   1. Focus on the entire system
   2. These invariants are usually stateful 
   3. Don't target specific element, but focus to cover entire system funcitonality
3. Valid State
   1. Enforcing valid states ensures that the user is always in one of theses states
4. State transition
   1. Ensure that changes occur in the correct order and conditions without desviations 
   2. Verified to occur only against specific functions, calls variable rules to prevent undesired state changes. 
   
## How build a fuzzing test ? 

1. Understand what the invariant are. 
2. Write funcitons that can execute.

## Methods 

1. **Stateless Fuzzing (Easiest)**

   This approach is useful when you have a _function that has an invariant_.  
   Randonm data to one function, where the state of the previous run is discarded. 

2. **Stateful Fuzzing - Open / Unguided (A little harder)**
   
   Random data & random functions call to many functions, where the final state of your previous run in the starting state of your next run.

   This approach send random data with random call, be is depende a lot of restiction is difficult to find a bugs. 

3. **Stateful Fuzzing - Handler method/ Guided (Harder)**
   
   This method use the same base the open, but handler the restrict our random inputs to set of specific random actions that can be called. 

4. **Formal Verification w/ Halmos (Hardest)**

### References

* [Cyfrin Updraft](https://updraft.cyfrin.io/)


### Open to Contributions
If you see some error, or want to add an observation, please create an issue or a PR. References are greatly appreciated. You can also contact me on Twitter at @pinalikefruit.

### Disclaimer
Take the observations in this repository as a guideline and kickstarter to make fuzzing test.