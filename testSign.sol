pragma solidity ^0.4.13;

contract ECRecoverTest {
    function testRecovery() public returns (address) {
        bytes32 foobar = 0x38d18acb67d25c8bb9942764b62f18e17054f66a817bd4295423adf9ed98873e;
        uint8 v = 0x1b;
        bytes32 r = 0x55ea6bcee40181d29523bdd00030bba4b035ba3e9782e67119cd3a5b7a037959;
        bytes32 s = 0x0d157379f4ee92ec6460e4c52754e9d905520ff5e8ed77e34b64c256539eec39;

        return ecrecover(foobar, v, r, s);
    }
}

