// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.7;

import "contracts/Whitelist.sol";

contract feesCollector{ //0xf8e81D47203A594245E36C48e151709F0C19fBe8
 
    address public owner ;
    uint256 public  balance ; 
    Whitelist internal  list ;

    constructor(){
        owner = msg.sender;  
         list = new Whitelist(10);
    }
    receive ()payable  external {
        require(exists() == true);
        require(msg.sender != owner  ,"admin can't pay to this wallet");
        balance += msg.value;  
    }

    function addSenderAdders() pure public {
        require(msg.sender ==  owner ," Only admin can add to whitlist");
         list.addAddressToWhitelist();
    }

    function withdrow( address payable  person , uint256 value) public {
        require(msg.sender ==  owner ," Only admin can withdraw");
        require(value <= balance ,"Insufficient funds");

        person.transfer(value);
        balance -= value;
    }

    function exists() internal   returns (bool) {
         if (list.getLength()){
            for (uint8 i = 0; i < list.getLength(); i++) {
                if (address[i] == msg.sender) {
                    return true;
                }
            }
            return false;
            } else{
               revert();
             }
        }
      
}

//https://dev.to/learnweb3/build-a-simple-whitelist-dapp-using-solidity-nextjs-ethersjs-on-ethereum-4c21