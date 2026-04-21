// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// Fixture that models an initializer-style delegate without access control.
/// Once an authority delegates to this contract, the first caller to reach
/// initialize() claims the owner slot permanently. Modeled after the
/// front-running footgun called out by the EIP-7702 security considerations.
contract UnsafeInitializer {
    address public owner;
    bool public initialized;

    event Initialized(address indexed context, address indexed newOwner, address indexed caller);

    function initialize(address newOwner) external {
        require(!initialized, "ALREADY_INITIALIZED");
        initialized = true;
        owner = newOwner;
        emit Initialized(address(this), newOwner, msg.sender);
    }
}

/// Fixture that records tx.origin, msg.sender, and address(this) into storage
/// so tests can verify that dApp-side "tx.origin == expected user" checks break
/// once a third-party sponsor submits the outer type-0x04 transaction on the
/// authority's behalf.
contract TxOriginSensor {
    address public observedOrigin;
    address public observedSender;
    address public observedSelf;

    function observe() external {
        observedOrigin = tx.origin;
        observedSender = msg.sender;
        observedSelf = address(this);
    }
}
