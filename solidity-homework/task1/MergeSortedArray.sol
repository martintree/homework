// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

/*
合并有序的两个数组
*/
contract MergeSortedArray {
     
     function merge(uint256[] calldata arr1, uint256[] calldata arr2) public pure returns (uint256[] memory) {
        require(arr1.length > 0 && arr2.length > 0, "Arrays should not be empty");
       
        uint256[] memory res = new uint256[](arr1.length + arr2.length);

        uint256 i = 0; //arr1's index
        uint256 j = 0; //arr2's index
        uint256 k = 0; //result's index
        while (i < arr1.length && j < arr2.length) {
            if (arr1[i] <= arr2[j]) {
                res[k++] = arr1[i++];
            } else {
                res[k++] = arr2[j++];
            }
            console.log("Value of k is:", k);
        }
        while (i < arr1.length) {
            res[k++] = arr1[i++];
        }
        while (j < arr2.length) {
            res[k++] = arr2[j++];
        }
        console.log("Final value of k is:", k);
        return res;
     }
}