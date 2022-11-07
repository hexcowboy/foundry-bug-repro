// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@forge-std/Test.sol";
import "@forge-std/StdCheats.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function testFuzzPayable(address[10] memory senders, uint256[10] memory amounts) public {
        for (uint256 i = 0; i < amounts.length; i++) {
            amounts[i] = bound(amounts[i], 0, 500);
            vm.assume(senders[i] != 0x000000000000000000636F6e736F6c652e6c6f67);
            StdCheatsSafe.assumeNoPrecompiles(senders[i]);
        }

        // add funds to contract
        vm.deal(address(counter), 1 ether);

        for (uint256 i = 0; i < senders.length; i++) {
            vm.startPrank(senders[i]);
            counter.hello(amounts[i]);
            vm.stopPrank();
        }
    }
}
