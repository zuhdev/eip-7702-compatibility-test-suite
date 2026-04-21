# EIP-7702 Compatibility Report

- **Suite:** eip-7702-compatibility-test-suite v0.2.0
- **Generated:** 2026-04-21T11:04:54.367Z

## Target

| Field | Value |
| --- | --- |
| Label | Managed local Anvil (Prague) |
| Kind | managed-anvil |
| Chain ID | 31337 |
| Hardfork | prague |
| RPC URL | `http://127.0.0.1:53373` |

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
| Transaction | `transaction.accepts_type_0x04` | PASS | 34ms |
| RPC | `rpc.estimates_gas_with_authorization_list` | PASS | 35ms |
| RPC | `rpc.eth_call_simulates_delegated_context` | PASS | 32ms |
| RPC | `rpc.eth_call_surfaces_revert_metadata` | PASS | 30ms |
| Authorization | `authorization.skips_invalid_chain_id` | PASS | 28ms |
| Authorization | `authorization.skips_invalid_nonce` | PASS | 28ms |
| Authorization | `authorization.accepts_chain_id_zero_for_any_chain` | PASS | 38ms |
| Authorization | `authorization.overwrites_existing_delegation` | PASS | 66ms |
| Authorization | `authorization.clears_with_zero_address` | PASS | 57ms |
| Authorization | `authorization.writes_contract_delegate_indicator` | PASS | 28ms |
| Execution | `execution.delegated_storage_write` | PASS | 47ms |
| Execution | `execution.delegation_persists_after_revert` | PASS | 30ms |
| Execution | `execution.codesize_vs_extcodesize` | PASS | 39ms |
| Security | `security.unsafe_initializer_can_be_frontrun` | PASS | 81ms |
| Security | `security.tx_origin_differs_from_authority` | PASS | 66ms |
| Security | `security.storage_persists_across_redelegations` | PASS | 108ms |

## Detailed results

### Transaction

#### `transaction.accepts_type_0x04`

**Status:** PASS · **Category:** Transaction · **Duration:** 34ms

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

**Status:** PASS · **Category:** RPC · **Duration:** 35ms

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

**Status:** PASS · **Category:** RPC · **Duration:** 32ms

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

**Status:** PASS · **Category:** RPC · **Duration:** 30ms

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

**Status:** PASS · **Category:** Authorization · **Duration:** 28ms

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

**Status:** PASS · **Category:** Authorization · **Duration:** 28ms

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

- transactionHash: `0x0c1d2b36bd2ac1eb2f263b3810861a31ee9cb9c53fde9c84b7086767e4915e9c`
- authority: `0x70aB79BCC8A0Aaf5032C0982A5734e13E02741F5`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- authorization: `0xf85a80945fbdb2315678afecb367f032d93f642f64180aa38080a080f139e7d7bd5f2e43f653c1680f5028153169e410935231fc2b6b91224de75ba028c93b07d2bb630ca3ff526f03ad886e8414f4fefa91e4fde93f4f8ab435da5f`
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

- authority: `0x85D851eBd24E8dFD98eAA5B667BEF2356EC7f117`
- firstTransactionHash: `0x474ebde397e2067249fa507b1fb2664fb2271049cced56fc748711cb65b94a27`
- secondTransactionHash: `0xa432283b13b18b6a898722595f01c42463f15a92dd87af4b824936fd04e39b79`
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

**Status:** PASS · **Category:** Execution · **Duration:** 30ms

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

**Status:** PASS · **Category:** Execution · **Duration:** 39ms

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

**Status:** PASS · **Category:** Security · **Duration:** 81ms

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

- authority: `0xB210006cfa19dF940972AB676Ce6F86e36Cb463E`
- unsafeInitializerDelegate: `0xe7f1725e7734ce288f8367e1bb143e90bb3f0512`
- delegationTransactionHash: `0x0f0ee2b8b7c1337a7cbca95178d11a71c738618f93c3e9f959a72329cccedbc4`
- attackerTransactionHash: `0xa00372428dd66730997bc141f538084796bc80f581219917655e0eca261a1469`
- attacker: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- observedOwner: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedInitialized: `1`
- note: `The sponsor races the authority's legitimate initializer and wins; any delegate without access control on initializer-style methods is exploitable post-delegation.`

#### `security.tx_origin_differs_from_authority`

**Status:** PASS · **Category:** Security · **Duration:** 66ms

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
  - expected: `0xbdad545f3964519dac316acdf0a321353248ed80`
  - actual: `0xbdad545f3964519dac316acdf0a321353248ed80`

**Evidence**

- authority: `0xbdAd545f3964519Dac316aCDF0a321353248ed80`
- sponsor: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- txOriginSensorDelegate: `0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0`
- transactionHash: `0xa588b5e7ee34db3b3bdcd7ec4e3655a43a29544286a358001be1d0dfa7bdaac1`
- observedOrigin: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSender: `0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266`
- observedSelf: `0xbdad545f3964519dac316acdf0a321353248ed80`
- note: `EIP-7702 does not change tx.origin semantics: the sponsor signing the outer transaction is tx.origin. Delegates that rely on tx.origin for authorization treat sponsored flows as the sponsor, not the authority.`

#### `security.storage_persists_across_redelegations`

**Status:** PASS · **Category:** Security · **Duration:** 108ms

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

- authority: `0xdC5924496467BAe3Bd71d7ef41A42C63AFbA33A1`
- delegateAddress: `0x5fbdb2315678afecb367f032d93f642f64180aa3`
- writeTransactionHash: `0xb4b7fe88531c38a59f6b5552199f9624189e96444de9994d8559f606847d42f8`
- clearTransactionHash: `0xb07f1f1221d4b6de5d3aa45ff6f7e4c1ef9834bba5ac124e05404751b09471e1`
- redelegationTransactionHash: `0x49ed067846f483ccee90ddb9ef3c7ab291c7b77bdebd9071267aa3c8a15e6e49`
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
