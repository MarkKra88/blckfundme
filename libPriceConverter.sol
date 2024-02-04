// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.7/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.7/vendor/SafeMathChainlink.sol";

library libPriceConverter{
    // safe math library check uint256 for integer overflows
    using SafeMathChainlink for uint256;
    
    // Use Oracle network to get ETH/USD price
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        // conversation rate after adjusting the extra 0s
        return ethAmountInUsd;
    }
}
