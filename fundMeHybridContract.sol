// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import {libPriceConverter} from "./libPriceConverter.sol";

contract fundMeContract{
    using libPriceConverter for uint256;
    //Set up  min. USD
    uint256 minimumUsd = 5e18;
    
    //Store donors
    address[] public donors;
    mapping(address => uint256) public addressToAmountDonated;

    // address public owner;
    // constructor() {
    //     owner = msg.sender;
    // }

    //Get funds
    function getFunds () public payable {
        //Set up Gwei requirment
        require(msg.value.getConversionRate() >= minimumUsd, "Not enough USD");
        addressToAmountDonated[msg.sender] += msg.value;
        donors.push(msg.sender);
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
