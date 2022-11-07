// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    function hello(uint256 amount) public {
        payable(msg.sender).transfer(amount);
    }
}
