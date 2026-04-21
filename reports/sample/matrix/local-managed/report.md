# EIP-7702 Compatibility Report

- **Suite:** eip-7702-compatibility-test-suite v0.2.0
- **Generated:** 2026-04-21T11:06:11.727Z

## Target

| Field | Value |
| --- | --- |
| Label | Managed local Anvil (Prague) |
| Kind | managed-anvil |
| Chain ID | 31337 |
| Hardfork | prague |
| RPC URL | `http://127.0.0.1:53395` |
| Config source | `/Users/vicgunga/EIP-7702 Compatibility Test Suite/targets/local-managed.json` |

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
| Transaction | `transaction.accepts_type_0x04` | PASS | 31ms |
| RPC | `rpc.estimates_gas_with_authorization_list` | PASS | 76ms |
| RPC | `rpc.eth_call_simulates_delegated_context` | PASS | 76ms |
| RPC | `rpc.eth_call_surfaces_revert_metadata` | PASS | 32ms |
| Authorization | `authorization.skips_invalid_chain_id` | PASS | 30ms |
| Authorization | `authorization.skips_invalid_nonce` | PASS | 29ms |
| Authorization | `authorization.accepts_chain_id_zero_for_any_chain` | PASS | 38ms |
| Authorization | `authorization.overwrites_existing_delegation` | PASS | 66ms |
| Authorization | `authorization.clears_with_zero_address` | PASS | 57ms |
| Authorization | `authorization.writes_contract_delegate_indicator` | PASS | 28ms |
| Execution | `execution.delegated_storage_write` | PASS | 47ms |
| Execution | `execution.delegation_persists_after_revert` | PASS | 29ms |
| Execution | `execution.codesize_vs_extcodesize` | PASS | 37ms |
| Security | `security.unsafe_initializer_can_be_frontrun` | PASS | 79ms |
| Security | `security.tx_origin_differs_from_authority` | PASS | 63ms |
| Security | `security.storage_persists_across_redelegations` | PASS | 105ms |

## Detailed results

### Transaction

#### `transaction.accepts_type_0x04`

**Status:** PASS · **Category:** Transaction · **Duration:** 31ms

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

- transactionHash: `0x0aad4271cdcfea6139c1bcb77d3c4b3f561a65aa161f7a7482d99f91bc208a2b`
- authority: `0x70997970C51812dc3A010C7d01b50e0d17dc79C8`
- delegateAddress: `0x0000000000000000000000000000000000000001`
- receiptType: `0x4`
- code: `0xef01000000000000000000000000000000000000000001`

### RPC

#### `rpc.estimates_gas_with_authorization_list`

**Status:** PASS · **Category:** RPC · **Duration:** 76ms

Uses eth_estimateGas with an authorizationList payload and delegated calldata to verify that provider-side simulation works before broadcast.

**Assertions**

- [x] Provider returns a positive gas estimate
  - expected: `> 0`
  - actual: `70730`
- [x] Estimate exceeds a plain 21k transfer
  - expected: `> 21000`
  - actual: `70730`

**Evidence**

- authority: `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a025624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490a06675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0x25624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490
  s: 0x6675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6
- calldata: `0x3fb5c1cb000000000000000000000000000000000000000000000000000000000000002a`
- estimate: `70730`
- estimateHex: `0x1144a`

#### `rpc.eth_call_simulates_delegated_context`

**Status:** PASS · **Category:** RPC · **Duration:** 76ms

Uses eth_call with an authorizationList payload against a clean authority and checks that delegated execution resolves address(this) to the authority.

**Assertions**

- [x] Delegated eth_call returns the authority as address(this)
  - expected: `0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc`
  - actual: `0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc`

**Evidence**

- authority: `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a025624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490a06675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0x25624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490
  s: 0x6675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6
- calldata: `0x4a5a8a3b`
- rawResult: `0x0000000000000000000000003c44cdddb6a900fa2b585dd299e03d12fa4293bc`
- resolvedContext: `0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc`

#### `rpc.eth_call_surfaces_revert_metadata`

**Status:** PASS · **Category:** RPC · **Duration:** 32ms

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

- authority: `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- signedAuthorization: `0xf85c827a69945fbdb2315678afecb367f032d93f642f64180aa38001a025624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490a06675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6`
- authorizationListEntry:
  chainId: 0x7a69
  address: 0x5fbdb2315678afecb367f032d93f642f64180aa3
  nonce: 0x0
  yParity: 0x01
  r: 0x25624a5a59ba3fd4a8b93d874183eb46eca7a9329a47081954554b3c3fa1e490
  s: 0x6675890c92133c78f8d8bec7781c278758aa19e02084cd44e08b6434d1409dc6
- calldata: `0x975af67a`
- errorCode: `3`
- errorMessage: `eth_call failed [3]: execution reverted: EXPECTED_REVERT`
- errorData: `0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f45585045435445445f5245564552540000000000000000000000000000000000`

### Authorization

#### `authorization.skips_invalid_chain_id`

**Status:** PASS · **Category:** Authorization · **Duration:** 30ms

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

- transactionHash: `0xb3b7edd8ea668697491ea01bbd045b259e061c1dd63c809f08a93a65e4e41e87`
- authority: `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC`
- attemptedDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- code: `0x`

#### `authorization.skips_invalid_nonce`

**Status:** PASS · **Category:** Authorization · **Duration:** 29ms

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

- transactionHash: `0x98ffafa397c3ce211e6f8f90d9602f224e3800dfd4bf053900e29f5ee2c0b025`
- authority: `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC`
- attemptedDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- attemptedNonce: `99`
- code: `0x`

#### `authorization.accepts_chain_id_zero_for_any_chain`

**Status:** PASS · **Category:** Authorization · **Duration:** 38ms

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

- transactionHash: `0x7fc55097340ed7eb493d1733a0f21978422527dd6c351be5d43f01c0de15c220`
- authority: `0xbF480F55e15f2Fd106db3Db9200dB1deac6CC827`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- authorization: `0xf85a80945fbdb2315678afecb367f032d93f642f64180aa38080a0d8e7e8ee7fb0b096cb954c9ec5faebd5e0db06e2b54ad51ab9b0003c679b1effa00e48459b17b886deaf7b56bfdc19378d06281920979b6015b80abd6eaa5d8105`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

#### `authorization.overwrites_existing_delegation`

**Status:** PASS · **Category:** Authorization · **Duration:** 66ms

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

- authority: `0x355A25D7D717190B2249F10F4a83461C818ad337`
- firstTransactionHash: `0x1176ccb7860ee642134c3d66bdb6e3ba59259081159db0c511646ec7f301ec01`
- secondTransactionHash: `0x5ba9772dd2475e905a29a00dea54fa64f7bd6cd2c5a0da375a95b5aeb8aa1332`
- firstDelegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- secondDelegateAddress: `0x0000000000000000000000000000000000000001`
- firstCode: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`
- secondCode: `0xef01000000000000000000000000000000000000000001`

#### `authorization.clears_with_zero_address`

**Status:** PASS · **Category:** Authorization · **Duration:** 57ms

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

- initialTransactionHash: `0x7173c89f6da07b5c930d47e66d6d442353b323ea990ea15f06080d5ed5fd3f70`
- clearingTransactionHash: `0x6405f1707db3ddecb20de10f5e9f5930aba054a6a3f9314553984cb5cb7eaf7e`
- authority: `0x90F79bf6EB2c4f870365E785982E1f101E93b906`
- code: `0x`

#### `authorization.writes_contract_delegate_indicator`

**Status:** PASS · **Category:** Authorization · **Duration:** 28ms

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

- transactionHash: `0x0be938c078a14dde6832d995fb93f222b67e7fde855c99d4a0cd349144852fd0`
- authority: `0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

### Execution

#### `execution.delegated_storage_write`

**Status:** PASS · **Category:** Execution · **Duration:** 47ms

Delegates an authority to the fixture contract, writes storage through the delegated entrypoint, and reads it back from the authority address.

**Assertions**

- [x] Delegated storage write transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority storage reflects the delegated write
  - expected: `42`
  - actual: `42`
- [x] address(this) resolves to the authority during delegated execution
  - expected: `0x9965507d1a55bcc2695c58ba16fb37d819b0a4dc`
  - actual: `0x9965507d1a55bcc2695c58ba16fb37d819b0a4dc`

**Evidence**

- transactionHash: `0xa6fc156cc56f3339fed65c30c2d2a7666b8cc68e2791544cba61fcfa2b7a820b`
- authority: `0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- storedNumber: `42`
- contextAddress: `0x9965507d1a55bcc2695c58ba16fb37d819b0a4dc`

#### `execution.delegation_persists_after_revert`

**Status:** PASS · **Category:** Execution · **Duration:** 29ms

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

- transactionHash: `0x8865577c489e2a671f8dc7fe7ec0086dbc14c70ab42d8bb239f3a4616db422f0`
- authority: `0x976EA74026E726554dB657fA54763abd0C3a0aa9`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

#### `execution.codesize_vs_extcodesize`

**Status:** PASS · **Category:** Execution · **Duration:** 37ms

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

- setupTransactionHash: `0x5cd050b4e0018fc71c37f7847007f1e82bc379074c020ee16c1a2a0861fa0c64`
- authority: `0x14dC79964da2C08b23698B3D3cc7Ca32193d9955`
- runtimeCodeSize: `449`
- authorityExtCodeSize: `23`
- code: `0xef01005fbdb2315678afecb367f032d93f642f64180aa3`

### Security

#### `security.unsafe_initializer_can_be_frontrun`

**Status:** PASS · **Category:** Security · **Duration:** 79ms

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

- authority: `0x1e5A11c2a7C38470D9fb667748A0D84B35E74b79`
- unsafeInitializerDelegate: `0xe7f1725e7734ce288f8367e1bb143e90bb3f0512`
- delegationTransactionHash: `0x9f10c7516984eca4860755dfa3275e6263364ee89455e95f726dd36e6b0ceca4`
- attackerTransactionHash: `0x02cc42b08c4af171de672a6e478c78ed22b1ccc9b56d4359262f912f1c67d2d1`
- attacker: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- observedOwner: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedInitialized: `1`
- note: `The sponsor races the authority's legitimate initializer and wins; any delegate without access control on initializer-style methods is exploitable post-delegation.`

#### `security.tx_origin_differs_from_authority`

**Status:** PASS · **Category:** Security · **Duration:** 63ms

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
  - expected: `0xe08d44b21dbcf06eea2c5efe69485cd5488ec422`
  - actual: `0xe08d44b21dbcf06eea2c5efe69485cd5488ec422`

**Evidence**

- authority: `0xE08D44b21dbcf06Eea2c5efE69485cd5488ec422`
- sponsor: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- txOriginSensorDelegate: `0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0`
- transactionHash: `0x5511c2975125462deb468fb6cfb064f81f5916a01eb082c1dee5a25d4bbb0c7c`
- observedOrigin: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSender: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSelf: `0xe08d44b21dbcf06eea2c5efe69485cd5488ec422`
- note: `EIP-7702 does not change tx.origin semantics: the sponsor signing the outer transaction is tx.origin. Delegates that rely on tx.origin for authorization treat sponsored flows as the sponsor, not the authority.`

#### `security.storage_persists_across_redelegations`

**Status:** PASS · **Category:** Security · **Duration:** 105ms

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

- authority: `0xFb586a1D265cB9a4E5116408a2Ffec34Bc3ca599`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- writeTransactionHash: `0x259009de6d143201fb0d34e92a07ccb1bbb3f35df710a07e299fe83a6199bbe1`
- clearTransactionHash: `0xe2bee1629f4aac8aaee905544bb60d941ebaa21540f05f0fa5c1c86281cc4a4f`
- redelegationTransactionHash: `0x8d4e32be4f3c1aca7c65321e93df33f8cb902646c43f48d3717270ca20fd0780`
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
- Target config source: /Users/vicgunga/EIP-7702 Compatibility Test Suite/targets/local-managed.json
