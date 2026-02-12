// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

/*
罗马数字转整数: CXCVI=196
*/
contract RomanToIntConverter {
    function romanToInt(string calldata s) public pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 total = 0;
        uint256 n = b.length;

        for (uint256 i = 0; i < n; i++) {
            uint256 currentVal = getRomanValue(b[i]);

            // 如果当前不是最后一个字符，且当前值小于下一个值（如 IV 中的 I < V）
            if (i < n - 1) {
                uint256 nextVal = getRomanValue(b[i + 1]);
                if (currentVal < nextVal) {
                    total -= currentVal;
                } else {
                    total += currentVal;
                }
            } else {
                // 最后一个字符总是相加
                total += currentVal;
            }
        }

        return total;
    }

     /**
     * @dev 获取罗马字符对应的数值
     */
    function getRomanValue(bytes1 char) internal pure returns (uint256) {
        if (char == 'I') return 1;
        if (char == 'V') return 5;
        if (char == 'X') return 10;
        if (char == 'L') return 50;
        if (char == 'C') return 100;
        if (char == 'D') return 500;
        if (char == 'M') return 1000;
        revert("Invalid Roman character");
    }
    
}