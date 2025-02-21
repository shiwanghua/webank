pragma solidity ^0.4.25;
//积分系统



contract LAGC{
    //1. 积分发行常量初始化
    string name = "LAGC";  // 积分名称 LIBRAIRIE AVANT-GARDE CREDIT 
    string symbol = "LAG"; // 积分简称 
    uint256 totalSupply; // 发行量
    
    // 地址对应余额 
    mapping (address => uint256) public balances; 
    // 用来通知客户端积分交易发生 
    event transferEvent(address from, address to, uint256 value);
    
    // 构造函数，由积分创建者执行：书店 
    constructor(uint256 initialSupply, string creditName, string creditSymbol) public { 
        //initialSupply:初始积分
        //creditName：积分名称
	    //creditSymbol：积分简称
        totalSupply = initialSupply; 
        balances[msg.sender] = totalSupply; 
        name = creditName; 
        symbol = creditSymbol; 

    }
    
    // 查询积分发放总额 
    function getTotalSupply() constant returns (uint256) { 
        return totalSupply; 
        
    }
    
    // 积分的发送函数，内部函数 
    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != 0x0); 
        require(balances[_from] >= _value); 
        require(balances[_to] + _value > balances[_to]); //_value不能为负值
        uint previousBalances = balances[_from] + balances[_to]; 
        balances[_from] -= _value; balances[_to] += _value;
        transferEvent(_from, _to, _value);   // 记录转账并通知客户端发生积分交易 
        assert(balances[_from] + balances[_to] == previousBalances);  
    }
    
    // 客户端调用的积分发送函数 
    function transfer(address _to, uint256 _value) public { 
        _transfer(msg.sender, _to, _value); 
    }
    
    // 查询账户余额 
    function balanceOf(address _owner) constant returns (uint256) { 
        return balances[_owner]; 
        
    }
    
    

}