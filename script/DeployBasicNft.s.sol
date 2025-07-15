// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployNft is Script {
    
    function run() public returns (BasicNft) {
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft(); // so it inherits itself from the ERC721 standard a dog nft collection, that we now want to modify (each nft a slightly different dog)
        vm.stopBroadcast();
        return basicNft;
    }
}