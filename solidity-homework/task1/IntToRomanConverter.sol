// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;

/*
阿拉伯数字转罗马数字
*/
contract IntToRomanConverter {
     
    function intToRoman(uint256 num) public pure returns(string memory) {
        require(num > 0 && num < 4000, "Number out of range (1-3999)");

        uint16[13] memory values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        string[13] memory symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

        bytes memory resStr; // 使用 bytes 动态拼接比 string 直接操作更高效

        for (uint i = 0; i < values.length && num > 0; i++) {
            // 贪心策略：只要当前数值还能减去，就一直减
            while (num >= values[i]) {
                num -= values[i];
                // 使用 abi.encodePacked 进行低成本字节拼接
                resStr = abi.encodePacked(resStr, bytes(symbols[i]));
            }
        }
        
        return string(resStr);

    }
}