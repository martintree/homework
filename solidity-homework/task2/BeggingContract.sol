// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.20;


contract BeggingContract{
    address public immutable owner;
    mapping(address => uint256) private donations;

// ===== 事件（关键操作链上留痕）=====
    //收到捐赠事件
    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    //资金提取事件
    event FundsWithdrawn(address indexed recipient, uint256 amount, uint256 timestamp);


    // ===== 修饰器 =====
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // ===== 构造函数 =====
    constructor() {
        owner = msg.sender;
    }

    //直接捐献
    function donate() external payable {
        doDonation(msg.sender, msg.value);
    }

    //转账
    receive() external payable { 
        doDonation(msg.sender, msg.value);
    }


    // ===== 内部逻辑：统一处理捐赠 =====
    function doDonation(address donor, uint256 amount) private {
        require(amount > 0, "Donation amount must be greater than zero");
        require(donor != address(0), "Invalid donor address");
        
        // 更新捐赠记录（累计）
        donations[donor] += amount;
        
        // 触发事件（供链下索引/前端展示）
        emit DonationReceived(donor, amount, block.timestamp);
    }

    // 查询捐助者捐献钱数
    function getDonation(address donor) external view  returns (uint256){
        return donations[donor];
    }

    //查询当前合约余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    //
    function withdraw() external onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");
        
        // 安全转账：使用 call（非 transfer）+ 结果检查
        (bool success, ) = payable(owner).call{value: amount}("");
        require(success, "Withdraw failed");
        
        emit FundsWithdrawn(owner, amount, block.timestamp);
    }
}   