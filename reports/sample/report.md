# EIP-7702 Conformance Report

- **Suite:** eip-7702-conformance-harness v0.2.0
- **Generated:** 2026-04-22T10:52:49.234Z

## Target

| Field | Value |
| --- | --- |
| Label | Managed local Anvil (Prague) |
| Kind | managed-anvil |
| Chain ID | 31337 |
| Hardfork | prague |
| RPC URL | `http://127.0.0.1:65439` |

### Deployed fixtures

| Fixture | Address | Runtime size |
| --- | --- | --- |
| DelegationTarget | `0x5fbdb2315678afecb367f032d93f642f64180aa3` | 449 bytes |
| UnsafeInitializer | `0xe7f1725e7734ce288f8367e1bb143e90bb3f0512` | 433 bytes |
| TxOriginSensor | `0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0` | 254 bytes |

## Summary

| Total | Passed | Failed | Skipped |
| --- | --- | --- | --- |
| 16 | 16 | 0 | 0 |

## Coverage by category

| Category | Passed | Failed | Total |
| --- | --- | --- | --- |
| Transaction | 1 | 0 | 1 |
| RPC | 3 | 0 | 3 |
| Authorization | 6 | 0 | 6 |
| Execution | 3 | 0 | 3 |
| Security | 3 | 0 | 3 |

## Results

| Category | Test | Result | Duration |
| --- | --- | --- | --- |
| Transaction | `transaction.accepts_type_0x04` | PASS | 51ms |
| RPC | `rpc.estimates_gas_with_authorization_list` | PASS | 55ms |
| RPC | `rpc.eth_call_simulates_delegated_context` | PASS | 47ms |
| RPC | `rpc.eth_call_surfaces_revert_metadata` | PASS | 47ms |
| Authorization | `authorization.skips_invalid_chain_id` | PASS | 42ms |
| Authorization | `authorization.skips_invalid_nonce` | PASS | 44ms |
| Authorization | `authorization.accepts_chain_id_zero_for_any_chain` | PASS | 42ms |
| Authorization | `authorization.overwrites_existing_delegation` | PASS | 78ms |
| Authorization | `authorization.clears_with_zero_address` | PASS | 76ms |
| Authorization | `authorization.writes_contract_delegate_indicator` | PASS | 44ms |
| Execution | `execution.delegated_storage_write` | PASS | 66ms |
| Execution | `execution.delegation_persists_after_revert` | PASS | 46ms |
| Execution | `execution.codesize_vs_extcodesize` | PASS | 59ms |
| Security | `security.unsafe_initializer_can_be_frontrun` | PASS | 94ms |
| Security | `security.tx_origin_differs_from_authority` | PASS | 77ms |
| Security | `security.storage_persists_across_redelegations` | PASS | 119ms |

## Detailed results

### Transaction

#### `transaction.accepts_type_0x04`

**Status:** PASS · **Category:** Transaction · **Duration:** 51ms

Submits a real type-0x04 transaction with a valid authorization and checks receipt typing plus delegation side effects.

**Assertions**

- [x] Receipt reports type 0x4
  - expected: `0x4`
  - actual: `0x4`
- [x] Transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Delegation indicator was written
  - expected: `0xef01000000000000000000000000000000000000000001`
  - actual: `0xef01000000000000000000000000000000000000000001`
- [x] Authority nonce increments to 1
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0x0e4be319216797d239497e837278035e8c3af438f4b76eb3f2e98b2472bcf11b`
- authority: `0xdE2B0BD52e1Ba44bC8B24Ca613cc03C5f72d7031`
- delegateAddress: `0x0000000000000000000000000000000000000001`
- receiptType: `0x4`
- code: `0xef01000000000000000000000000000000000000000001`

### RPC

#### `rpc.estimates_gas_with_authorization_list`

**Status:** PASS · **Category:** RPC · **Duration:** 55ms

Uses eth_estimateGas with an authorizationList payload and delegated calldata to verify that provider-side simulation works before broadcast.

**Assertions**

- [x] Provider returns a positive gas estimate
  - expected: `> 0`
  - actual: `70730`
- [x] Estimate exceeds a plain 21k transfer
  - expected: `> 21000`
  - actual: `70730`

**Evidence**

- authority: `0x1C3123b89F3E2a0Ac306CA235bb85520E4bc66c6`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a0e642724aa3a67a99fe1a7ff0d1703ed91842fc4e49247cc9981bde68992dc699a01f67bc91695fe86f1e0e76ebe225e5ea46505a1087a5bab6a757c700e0749fb0`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0xe642724aa3a67a99fe1a7ff0d1703ed91842fc4e49247cc9981bde68992dc699
  s: 0x1f67bc91695fe86f1e0e76ebe225e5ea46505a1087a5bab6a757c700e0749fb0
- calldata: `0x3fb5c1cb000000000000000000000000000000000000000000000000000000000000002a`
- estimate: `70730`
- estimateHex: `0x1144a`

#### `rpc.eth_call_simulates_delegated_context`

**Status:** PASS · **Category:** RPC · **Duration:** 47ms

Uses eth_call with an authorizationList payload against a clean authority and checks that delegated execution resolves address(this) to the authority.

**Assertions**

- [x] Delegated eth_call returns the authority as address(this)
  - expected: `0xf20a869102ac25684910372e9d73cd59c2ca0955`
  - actual: `0xf20a869102ac25684910372e9d73cd59c2ca0955`

**Evidence**

- authority: `0xF20A869102ac25684910372E9D73CD59C2Ca0955`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a07d03efbc292771cf98374709761519756e529e7e67f2c621605811f2e2c78848a04a20432ddeb193182099f1a7d71551c19d3274cf0096205d845f60971c1501d6`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0x7d03efbc292771cf98374709761519756e529e7e67f2c621605811f2e2c78848
  s: 0x4a20432ddeb193182099f1a7d71551c19d3274cf0096205d845f60971c1501d6
- calldata: `0x4a5a8a3b`
- rawResult: `0x000000000000000000000000f20a869102ac25684910372e9d73cd59c2ca0955`
- resolvedContext: `0xf20a869102ac25684910372e9d73cd59c2ca0955`

#### `rpc.eth_call_surfaces_revert_metadata`

**Status:** PASS · **Category:** RPC · **Duration:** 47ms

Uses eth_call with an authorizationList payload against a reverting delegated function and verifies that provider error metadata remains actionable.

**Assertions**

- [x] Provider returns a structured RPC error
  - expected: `RpcRequestError`
  - actual: `RpcRequestError`
- [x] Error message preserves the revert reason
  - expected: `message contains EXPECTED_REVERT`
  - actual: `eth_call failed [3]: execution reverted: EXPECTED_REVERT`
- [x] Error data preserves ABI-encoded revert payload
  - expected: `0x08c379a0...`
  - actual: `0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f45585045435445445f5245564552540000000000000000000000000000000000`

**Evidence**

- authority: `0x8D1bd46EcC388F993E141D9d0Fa0F09F2D148340`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a06a4ddb6c007f83b9a23a0d7fa9b411afdab448bedda09288f4429b53627660e6a05ce37075c6b6f5ab99ac503dbf91355506e0be234e356ade7139a75a8645a759`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0x6a4ddb6c007f83b9a23a0d7fa9b411afdab448bedda09288f4429b53627660e6
  s: 0x5ce37075c6b6f5ab99ac503dbf91355506e0be234e356ade7139a75a8645a759
- calldata: `0x975af67a`
- errorCode: `3`
- errorMessage: `eth_call failed [3]: execution reverted: EXPECTED_REVERT`
- errorData: `0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f45585045435445445f5245564552540000000000000000000000000000000000`

### Authorization

#### `authorization.skips_invalid_chain_id`

**Status:** PASS · **Category:** Authorization · **Duration:** 42ms

Signs an authorization for a mismatched chain ID and verifies the transaction still mines while the authority remains unchanged.

**Assertions**

- [x] Transaction still succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority code remains empty
  - expected: `0x`
  - actual: `0x`
- [x] Authority nonce does not change
  - expected: `0`
  - actual: `0`

**Evidence**

- transactionHash: `0x8f596e6969debe1182b1f3d1592c9ec30c115d06dc9066b6b3e3bf70fbf618b7`
- authority: `0x4f2fdE3BB5234665188cC5EE90443c6f04D3578d`
- attemptedDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- code: `0x`

#### `authorization.skips_invalid_nonce`

**Status:** PASS · **Category:** Authorization · **Duration:** 44ms

Signs an authorization with a nonce that does not match the authority's current nonce and verifies the outer transaction still mines while the authority remains unchanged.

**Assertions**

- [x] Transaction still succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority code remains empty
  - expected: `0x`
  - actual: `0x`
- [x] Authority nonce does not change
  - expected: `0`
  - actual: `0`

**Evidence**

- transactionHash: `0x7e54f7bb32fa464f27685f2184877cfc7c1577f58675e70b82bf772252f72195`
- authority: `0x625cC99D3bE9114Bdc66940241e7ac282a3F52eF`
- attemptedDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- attemptedNonce: `99`
- code: `0x`

#### `authorization.accepts_chain_id_zero_for_any_chain`

**Status:** PASS · **Category:** Authorization · **Duration:** 42ms

Signs an authorization with chain_id=0 (chain-agnostic per EIP-7702) and verifies it is accepted on the target chain with the expected delegation side effects.

**Assertions**

- [x] Transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Delegation indicator is written despite chain_id=0
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- [x] Authority nonce increments for the replay-safe authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0x57f5af5d2446f2d055781b02eb56159f3773c78fbf8b00878cd96821d890a168`
- authority: `0xc8Ff7f0525c264A1Ebe902D2Fd51bb63f811Fc55`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- authorization: `0xf85a80945fbdb2315678afecb367f032d93f642f64180aa38080a05f036016e08a837f06bfe035874cb28d3a0574472f0b68990910aa556922e5fca03dce3e64cf102c74b76965c5141e9603edef9b525e95a1f42815deb8e73838a9`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

#### `authorization.overwrites_existing_delegation`

**Status:** PASS · **Category:** Authorization · **Duration:** 78ms

Delegates an authority to the fixture contract, then re-delegates the same authority to a different target and verifies the indicator swaps while the nonce increments twice.

**Assertions**

- [x] First delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] First indicator points at the fixture
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- [x] Second delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Second indicator overwrites the first
  - expected: `0xef01000000000000000000000000000000000000000001`
  - actual: `0xef01000000000000000000000000000000000000000001`
- [x] Authority nonce increments twice
  - expected: `2`
  - actual: `2`

**Evidence**

- authority: `0x7507C2370dFF5dAedd1299dD941891E28F8fb41e`
- firstTransactionHash: `0x785ce18e3f96c5bf991168a08cada0c2262de68e3335c86b7a7134e594e3578d`
- secondTransactionHash: `0xbdbeac9bac7d0f19160908b33f7c0d9110c21bc436420bedc54383e93395136c`
- firstDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- secondDelegateAddress: `0x0000000000000000000000000000000000000001`
- firstCode: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- secondCode: `0xef01000000000000000000000000000000000000000001`

#### `authorization.clears_with_zero_address`

**Status:** PASS · **Category:** Authorization · **Duration:** 76ms

Applies a valid delegation first, then sends a second valid authorization to the zero address and verifies that the authority code is cleared.

**Assertions**

- [x] Initial delegation succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Clearing transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority code is cleared
  - expected: `0x`
  - actual: `0x`
- [x] Authority nonce increments twice
  - expected: `2`
  - actual: `2`

**Evidence**

- initialTransactionHash: `0x008c7753ed3e36e0299694859a86614ee9cb81c49dadd85c44999a5d348f13e3`
- clearingTransactionHash: `0x8a0119ca6aa1e1cc5fb2da0828e018732125b34807854ae84f7628d6d6dad16d`
- authority: `0x4496986424Fd7F9b35697Bf63f45C0D3CA64df3b`
- code: `0x`

#### `authorization.writes_contract_delegate_indicator`

**Status:** PASS · **Category:** Authorization · **Duration:** 44ms

Applies a valid authorization that points to the deployed fixture contract and verifies that the indicator and nonce update match the expected contract delegation path.

**Assertions**

- [x] Contract-target authorization transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Indicator points at the deployed fixture contract
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- [x] Authority nonce increments once for the valid authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0x7089a2eaea3d12d9fcdbb83b4ce3bc1b9d9b35da59458873459a10b345fe032b`
- authority: `0x6194aDcDC28001db78f0c3cC17a2000e8Bab19d5`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

### Execution

#### `execution.delegated_storage_write`

**Status:** PASS · **Category:** Execution · **Duration:** 66ms

Delegates an authority to the fixture contract, writes storage through the delegated entrypoint, and reads it back from the authority address.

**Assertions**

- [x] Delegated storage write transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority storage reflects the delegated write
  - expected: `42`
  - actual: `42`
- [x] address(this) resolves to the authority during delegated execution
  - expected: `0x186f56bf6bb30219a5e051bec5792322fc92d9da`
  - actual: `0x186f56bf6bb30219a5e051bec5792322fc92d9da`

**Evidence**

- transactionHash: `0x0f2f2010a6c2d867dcf65b45b608642cc19386c1aabf951ce474083aa951121f`
- authority: `0x186f56BF6Bb30219A5e051bec5792322Fc92d9da`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- storedNumber: `42`
- contextAddress: `0x186f56bf6bb30219a5e051bec5792322fc92d9da`

#### `execution.delegation_persists_after_revert`

**Status:** PASS · **Category:** Execution · **Duration:** 46ms

Delegates an authority and immediately calls a reverting function through the delegated code path to confirm the code write survives a failed execution.

**Assertions**

- [x] Outer execution reverts
  - expected: `0x0`
  - actual: `0x0`
- [x] Delegation indicator still persists
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- [x] Authority nonce still increments for the valid authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0xcf4cddc9883724f3cdca4effba3c46f6b4b6ab7822512a68dd2a33e6a1762325`
- authority: `0x9805EcA7AadeEE3FeDcc6c220FdAD1Ebd9a27597`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

#### `execution.codesize_vs_extcodesize`

**Status:** PASS · **Category:** Execution · **Duration:** 59ms

Delegates an authority to the fixture contract and verifies that delegated execution sees the target runtime code size while external inspection sees the short delegation indicator.

**Assertions**

- [x] Setup delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Delegated execution sees the fixture runtime size
  - expected: `449`
  - actual: `449`
- [x] External code size of the authority matches the 23-byte delegation indicator
  - expected: `23`
  - actual: `23`
- [x] Authority code stores the fixture delegation indicator
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

**Evidence**

- setupTransactionHash: `0x1c2971757453387303c3a30cad8952d26f98c29b1933a241709f54919a351b86`
- authority: `0xf8A12514C6944DCB31846c8F0d5E7eaF99085556`
- runtimeCodeSize: `449`
- authorityExtCodeSize: `23`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

### Security

#### `security.unsafe_initializer_can_be_frontrun`

**Status:** PASS · **Category:** Security · **Duration:** 94ms

Delegates an authority to an UnsafeInitializer contract and has the sponsor claim the owner slot before the authority ever gets a chance, demonstrating why initializer-without-access-control patterns are dangerous under EIP-7702.

**Assertions**

- [x] Delegation setup transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Sponsor-submitted initialize() call succeeds against the delegated authority
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority storage now marks the contract as initialized
  - expected: `1`
  - actual: `1`
- [x] Attacker (sponsor) captured the owner slot in authority storage
  - expected: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
  - actual: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`

**Evidence**

- authority: `0xE829834754E919bFEf68A0F177c798a31e8Dc999`
- unsafeInitializerDelegate: `0xe7f1725e7734ce288f8367e1bb143e90bb3f0512`
- delegationTransactionHash: `0x335617e5510e45d2d9730a150c60a26514ee235aeab84fee16167e67aac0f7d4`
- attackerTransactionHash: `0xf332aab042751bbaf28c282509792ae8c651b9459db35ecbbf302a4fe1c73c4b`
- attacker: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- observedOwner: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedInitialized: `1`
- note: `The sponsor races the authority's legitimate initializer and wins; any delegate without access control on initializer-style methods is exploitable post-delegation.`

#### `security.tx_origin_differs_from_authority`

**Status:** PASS · **Category:** Security · **Duration:** 77ms

Delegates an authority to a TxOriginSensor contract and submits a sponsor-signed type-0x04 call to observe(). The sensor stores tx.origin/msg.sender/address(this) in authority storage so the test can prove tx.origin resolves to the sponsor (breaking any dApp-side "tx.origin == expected user" check).

**Assertions**

- [x] Delegated observe() transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] tx.origin resolves to the sponsor (not the authority)
  - expected: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
  - actual: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- [x] msg.sender at the entrypoint is the sponsor (top-level call from sponsor EOA)
  - expected: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
  - actual: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- [x] address(this) during delegated execution is the authority
  - expected: `0xca01f3fa1e349f849d7cca0204ec1e818e5279db`
  - actual: `0xca01f3fa1e349f849d7cca0204ec1e818e5279db`

**Evidence**

- authority: `0xca01F3fa1e349F849d7CCA0204Ec1e818E5279dB`
- sponsor: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- txOriginSensorDelegate: `0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0`
- transactionHash: `0x04a398c35d125f7f6518ceea88daca9fbb68fda9ca25943bc762572f36cd00e2`
- observedOrigin: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSender: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSelf: `0xca01f3fa1e349f849d7cca0204ec1e818e5279db`
- note: `EIP-7702 does not change tx.origin semantics: the sponsor signing the outer transaction is tx.origin. Delegates that rely on tx.origin for authorization treat sponsored flows as the sponsor, not the authority.`

#### `security.storage_persists_across_redelegations`

**Status:** PASS · **Category:** Security · **Duration:** 119ms

Delegates an authority to the fixture, writes storage through the delegated code, clears the delegation to the zero address, and re-delegates. Reads storage again through the new delegation and verifies the prior value survived, proving storage is bound to the authority address and not to the delegate code.

**Assertions**

- [x] Initial delegated write transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Clearing delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority code is empty after clearing delegation
  - expected: `0x`
  - actual: `0x`
- [x] Re-delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Indicator points at the fixture after re-delegation
  - expected: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
  - actual: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- [x] Previously written storage value survives the clear/re-delegation cycle
  - expected: `424242`
  - actual: `424242`
- [x] Authority nonce increments three times across the cycle
  - expected: `3`
  - actual: `3`

**Evidence**

- authority: `0x1A9F8d0F7f96a79eE3F506E33271d07f2560Ac9d`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- writeTransactionHash: `0x173c4e06a14979c918b26d32fd93e11ed978fb46867ce577e48d7deb042a61f6`
- clearTransactionHash: `0x8b05b87be4f57c8932f1916950ded7b8b6a585f1c1823c06efd1c4f2ff038012`
- redelegationTransactionHash: `0xf98e6dbf7cfab8b6c1462a4e7915dab4705422d0ea06a96e8e284feb02fc3dd4`
- writeValue: `424242`
- observedStoredNumber: `424242`
- codeAfterClear: `0x`
- codeAfterRedelegation: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- note: `Storage is keyed by the authority address, not by the delegate's code hash. A new delegate inherits whatever storage the authority already holds, so delegates that assume "fresh state" at any slot can be misled after a re-delegation.`

## Notes

- Managed local Anvil targets are pinned to an explicit hardfork so support is deterministic instead of relying on tooling defaults.
- This run uses real raw transaction signing plus JSON-RPC submission rather than mocked transport behavior.
- The fixture contract is deployed fresh per target so each run has isolated execution evidence.
- The report format is designed to extend toward wallet adapters, relayers, and multi-provider CI publishing.
