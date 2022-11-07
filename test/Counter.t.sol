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

    uint256 constant LOAD = 10;

    function testFuzzPayable(
        address[LOAD] memory senders,
        uint256[LOAD] memory amounts
    ) public {
        for (uint256 i = 0; i < LOAD; i++) {
            amounts[i] = bound(amounts[i], 0, 500);
            vm.assume(senders[i] != 0x000000000000000000636F6e736F6c652e6c6f67);
            vm.assume(senders[i] != 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
            vm.assume(senders[i] != 0x4e59b44847b379578588920cA78FbF26c0B4956C);
            vm.assume(senders[i] != 0xCe71065D4017F316EC606Fe4422e11eB2c47c246);
            vm.assume(senders[i] != address(this));
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
