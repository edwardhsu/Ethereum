contract Escrew {
    
    uint  REFUSE_TO_ARBITRATE = 0;
    uint  PAY_PAYEE = 1;
    uint  REIMBURSE_PAYER = 2;
    
    address payable public payee;
    address payable public payer;
    address public arbitrator;
    
    constructor (address payable _payee, address _arbitrator) payable public {
        payer = msg.sender;
        payee = _payee;
        arbitrator = _arbitrator;
    }
    
    function pay() payable public {
        
        require(msg.sender == payer);
        payee.send(address(this).balance);
    }
    
    function reimburse() payable public {
        
        require(msg.sender == payee);
        payer.send(address(this).balance);
    }
    
    function rule(uint _ruling) payable public {
        
        require(msg.sender == arbitrator);
        uint totalAmount = address(this).balance;
        
        if (_ruling == PAY_PAYEE) {
            payee.send(totalAmount);
        } else if (_ruling == REIMBURSE_PAYER){
            payer.send(totalAmount);
        } else {
            payee.send(totalAmount/2);
            payer.send(totalAmount/2);
        }
    }    
}
