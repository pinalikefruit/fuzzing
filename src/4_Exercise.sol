pragma solidity 0.8.20;

contract Safe {

    address public seller = msg.sender;
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balance[msg.sender];
        balance[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "failed to send");
    }

    function sendSomeEther(address to, uint amount) public {
        (bool success, ) = to.call{value: amount}("");
        require(success, "failed to send");
    }

    // By adding a function to the contract that can be used to send ether to a different account, the invariant of withdrawing always the same amount of deposited ether is broken.
    
    receive() external payable {}
}