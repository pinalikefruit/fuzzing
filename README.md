# Fuzzing Zone

Here you can find all important concepts, exercises, implementations, and step-by-step guides for increasing your knowledge around Fuzzing.

## What is Fuzz Test

Fuzzing is a technique where the goal is to break the invariants of the contract by trying to break specific assertions with random data.

The benefit is that the contract is exposed to extreme conditions, helping to uncover hard-to-detect vulnerabilities.

## What is an Invariant

Invariants are properties of our system that should always hold true.

E.g. A user should never be able to withdraw more money than they deposited

Defining good invariants is key; it shows that you truly understand and can explain in plain English what the protocol does and what it doesn't. You can get the idea from whitepapers (abstracted), docs, or the Solidity codebase.

### Types of Invariants: 

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
5. Variable Transitions
   1. This verification ensures, similarly to state transitions, that variables change consistently.
   2. Different variables may have distinct change patterns, with some required to change only in specific directions for the system's coherence.
   
## How build a fuzzing test ? 

1. Define Invariants from Documentation
2. Write Your Properties in Plain English (PROPERTIES.md)
3. Categore Your Properties
4. Prioritize Your Invariants (A good strategy can be to start with the "easier to implement" and "most impactful" first)
5. Writing Solidity Code for Invariants
   
## Methods 

1. **Stateless Fuzzing (Easiest)**

   This approach is useful when you have a _function that has an invariant_.
   Random data to one function, where the state of the previous run is discarded.

2. **Stateful Fuzzing - Open / Unguided (A little harder)**
   
   Random data & random function calls to many functions, where the final state of your previous run is the starting state of your next run.

   This approach sends random data with random calls, but depending on the number of restrictions, it can be difficult to find bugs. 

3. **Stateful Fuzzing - Handler method/ Guided (Harder)**
   
   This method uses the same base as the open method but handles the restrictions on our random inputs to a set of specific random actions that can be called.

4. **Formal Verification w/ Halmos (Hardest)**

## Fuzzing tools 

* [Foundry](https://book.getfoundry.sh/) 
  * [Getting Started](./docs/foundry.md)
  * [Exercise](./docs/foundry-exercise.md)
* Echidna

### References

* [Cyfrin Updraft](https://updraft.cyfrin.io/)
* [All things fuzzy](https://allthingsfuzzy.substack.com/)
* [Invariant testing](https://book.getfoundry.sh/forge/invariant-testing)

###  Lecture
* [What is fuzzing (fuzz tests)](https://www.cyfrin.io/blog/smart-contract-fuzzing-and-invariants-testing-foundry)
* [Quick tips to start your next invariant test campaign](https://allthingsfuzzy.substack.com/p/quick-tips-to-start-your-next-invariant)

### Tutorial 

* [Invariant Testing WETH With Foundry](https://mirror.xyz/horsefacts.eth/Jex2YVaO65dda6zEyfM_-DXlXhOWCAoSpOx5PLocYgw) 
  
### Open to Contributions
If you see any errors or want to add an observation, please create an issue or a PR. References are greatly appreciated. You can also contact me on Twitter at [@pinalikefruit](https://x.com/pinalikefruit).

### Disclaimer
Take the observations in this repository as guidelines and a kickstarter to make fuzzing tests. This repo may contain errors or incorrect assumptions. If you find any, please help by creating an issue or a PR.


