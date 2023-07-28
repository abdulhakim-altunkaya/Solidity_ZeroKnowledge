// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Zero1 {

    event SecretNumRevealed(uint _secretNum);

    uint private secretNum;
    bytes32 private hashedSecretNum;

    address public verifier;


    modifier onlyVerifier() {
        require(msg.sender == verifier, "you are not verifier");
        _;
    }

    constructor() {
        verifier = msg.sender;
    }

    function setSecretNum(uint _secretNum) public {
        secretNum = _secretNum;
        hashedSecretNum = keccak256(abi.encodePacked(_secretNum));
    }


    function verifyProof(uint _proof) public onlyVerifier {
        require(keccak256(abi.encodePacked(_proof)) == hashedSecretNum, "Proof verification failed");
        emit SecretNumRevealed(_proof);
    }
}