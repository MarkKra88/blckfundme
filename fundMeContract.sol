// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract fundMeContract{
    //Set up  min. Gwei treshold (0.01 ETH)
    uint256 internal minimumGwei = 10000000;
    
    //Store donors
    address[] public donors;
    mapping (address => uint256) public addressToAmountDonated;

    // address public owner;
    // constructor() {
    //     owner = msg.sender;
    // }

    //Get funds
    function getFunds () public payable {
        //Set up Gwei requirment
        require(msg.value >= minimumGwei, "Not enough Gwei");
        donors.push(msg.sender);
        addressToAmountDonated[msg.sender] += msg.value;
    }


    //Withdraw funds

    function withdrawFunds() public /*onlyOwner*/ {       

        // Get the amount donated by the caller
        uint256 amountToWithdraw = addressToAmountDonated[msg.sender];

        // Reset the amount donated by the caller to zero
        addressToAmountDonated[msg.sender] = 0;

        // Send money back to the caller
        payable(msg.sender).transfer(amountToWithdraw);
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "You must be an owner of a contract!"); 
    //     _;
    // }
}
