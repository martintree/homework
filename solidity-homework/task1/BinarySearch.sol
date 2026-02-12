// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;


import "hardhat/console.sol";
/*
二分查找
*/
contract BinarySearch{
    /**
     * @dev 在有序数组中查找目标值的索引
     * @param arr 升序排列的数组
     * @param target 要寻找的值
     * @return found 是否找到
     * @return index 目标值的索引（若未找到则返回 0，需配合 found 标志使用）
     */
    function binarySearch(uint256[] calldata arr, uint256 target) external pure returns (bool found, uint256 index) {
        if (arr.length == 0) return (false, 0);

        uint256 low = 0;
        uint256 high = arr.length - 1;

        while (low <= high) {
            // 防止 (low + high) 溢出的安全写法（虽然 Solidity 0.8+ 自带溢出检查，但这更专业）
            uint256 mid = low + (high - low) / 2;
             console.log("Value of mid is:", mid);
            uint256 midVal = arr[mid];

            if (midVal == target) {
                return (true, mid);
            } else if (midVal < target) {
                low = mid + 1;
            } else {
                // 处理无符号整数下溢：当 high 为 0 时执行 mid - 1 会报错
                if (mid == 0) break; 
                high = mid - 1;
            }
        }

        return (false, 0);
    }

}