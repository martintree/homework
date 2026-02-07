// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
一个mapping来存储候选人的得票数
一个vote函数，允许用户投票给某个候选人
一个getVotes函数，返回某个候选人的得票数
一个resetVotes函数，重置所有候选人的得票数
*/
contract Voting {
    //记录得票数
    mapping ( address => uint ) public votesReceived;
     //记录候选人列表
    address[] public candidateList;

    //投票函数
    function vote(address candidate) public {
        require(candidate != address(0), "You can't vote for the zero address!");
        require(candidate != msg.sender, "You can't vote for yourself!");
    //记录被投票的人
    if (votesReceived[candidate] == 0){
        candidateList.push(candidate);
    }
        votesReceived[candidate] += 1;
    }

    //返回某个候选人的得票数
    function getVotes(address candidate) public view returns (uint){
         require(candidate != address(0), "You can't input zero address!");
         return votesReceived[candidate];
    }
    
    //重置投票
    function resetVotes() public {
        for (uint i=0;i<candidateList.length;i++){
            delete votesReceived[candidateList[i]];
        }
        delete candidateList;
    }
}