contract Escrew {
    
    uint  REFUSE_TO_ARBITRATE = 0;
    uint  PAY_PAYEE = 1;
    uint  REIMBURSE_PAYER = 2;
    
    address payable public payee;
    address payable public payer;
    address public arbitrator;
    
    constructor (address payable _payee, address _arbitrator) payable public {
        payee = _payee;
        payer = msg.sender;
        arbitrator = _arbitrator;
    }
    
    function pay() public {
        require(msg.sender == payer);
        payee.send(address(this).balance);
    }
    
    function reimburse() public {
        require(msg.sender == payee);
        payer.send(address(this).balance);
    }
    
    function rule(uint _ruling) public {
        require(msg.sender == arbitrator);
        uint totalAmount = address(this).balance;
        
        if (_ruling == PAY_PAYEE) {
            payee.send(totalAmount);
        } else if (_ruling == REIMBURSE_PAYER){
            payer.send(totalAmount);
        } else {
            payee.send(totalAmount/2);
            payee.send(totalAmount/2);
        }
    }    
}
