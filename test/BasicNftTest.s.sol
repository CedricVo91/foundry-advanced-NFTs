// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test{
    DeployNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {

        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // we can't compare strings, nor arrays in solidity -> only primitive types like bytes etc.
        // we can though compare the two hashes!
        // to hash any object in solidity, we need to transform it into bytes and store it in data location (best to use memory as we only need it within the function call)
        bytes memory expectedNameInBytes = abi.encodePacked(expectedName);
        bytes memory actualNameInBytes = abi.encodePacked(actualName);
        assert(keccak256(expectedNameInBytes) == keccak256(actualNameInBytes));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        // here again: as the uri link is of type string i.e. a reference type we need to hash it!
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

}