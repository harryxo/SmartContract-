// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}


contract FundMe { 
    
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {

        addressToAmountFunded[msg.sender] += msg.value;
        // Whats the ETH -> USD conversion rate 
        
    }

    
    function getVersion() public view returns (uint256){
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x4b956f321b1f11C23C0ED6bE6429890521D4Fb9a);
         return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x4b956f321b1f11C23C0ED6bE6429890521D4Fb9a);
        (,int256 answer,,,) = priceFeed.latestRoundData();
         // ETH/USD rate in 18 digit 
         return uint256(answer);
    }

}
