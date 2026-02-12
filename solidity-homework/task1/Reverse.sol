// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
反转字符串
*/
contract Reverse {
     
    function reverseString(string memory str) public pure returns(string memory) {
        bytes memory bytesStr = bytes(str);
        uint len = bytesStr.length;

        if(len<=1){
            return str;
        }

        bytes memory reverseStr = new bytes(len);

        for (uint i=0;i<len;i++){
            reverseStr[i]=bytesStr[len - 1 - i];
        }    
        return string(reverseStr);
    }
      
}