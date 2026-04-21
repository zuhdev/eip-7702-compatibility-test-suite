# EIP-7702 Conformance Report

- **Suite:** eip-7702-conformance-harness v0.2.0
- **Generated:** 2026-04-22T10:49:43.274Z

## Target

| Field | Value |
| --- | --- |
| Label | Hoodi (Alchemy) |
| Kind | rpc |
| Chain ID | 560048 |
| Hardfork | prague |
| RPC URL | `https://eth-hoodi.g.alchemy.com/***` |
| Config source | `targets/hoodi.local.json` |

### Deployed fixtures

| Fixture | Address | Runtime size |
| --- | --- | --- |
| DelegationTarget | `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a` | 449 bytes |
| UnsafeInitializer | `0xf52f301da2b96b642edc8c0cee1c5a45d7e3f3d4` | 433 bytes |
| TxOriginSensor | `0xe9850562476e7cbcf3d825ae794ec4bc5b48f378` | 254 bytes |

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
| Transaction | `transaction.accepts_type_0x04` | PASS | 13688ms |
| RPC | `rpc.estimates_gas_with_authorization_list` | PASS | 2586ms |
| RPC | `rpc.eth_call_simulates_delegated_context` | PASS | 518ms |
| RPC | `rpc.eth_call_surfaces_revert_metadata` | PASS | 616ms |
| Authorization | `authorization.skips_invalid_chain_id` | PASS | 11176ms |
| Authorization | `authorization.skips_invalid_nonce` | PASS | 10069ms |
| Authorization | `authorization.accepts_chain_id_zero_for_any_chain` | PASS | 14321ms |
| Authorization | `authorization.overwrites_existing_delegation` | PASS | 45393ms |
| Authorization | `authorization.clears_with_zero_address` | PASS | 60333ms |
| Authorization | `authorization.writes_contract_delegate_indicator` | PASS | 11909ms |
| Execution | `execution.delegated_storage_write` | PASS | 16455ms |
| Execution | `execution.delegation_persists_after_revert` | PASS | 7269ms |
| Execution | `execution.codesize_vs_extcodesize` | PASS | 12288ms |
| Security | `security.unsafe_initializer_can_be_frontrun` | PASS | 27646ms |
| Security | `security.tx_origin_differs_from_authority` | PASS | 7512ms |
| Security | `security.storage_persists_across_redelegations` | PASS | 40718ms |

## Detailed results

### Transaction

#### `transaction.accepts_type_0x04`

**Status:** PASS · **Category:** Transaction · **Duration:** 13688ms

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

- transactionHash: `0xf993d98422524904934def294e20cc001c04218647a73b71d62bb44fb7006092`
- authority: `0xd9397497622A75Cc11997c57A4D58514aAaA7E9D`
- delegateAddress: `0x0000000000000000000000000000000000000001`
- receiptType: `0x4`
- code: `0xef01000000000000000000000000000000000000000001`

### RPC

#### `rpc.estimates_gas_with_authorization_list`

**Status:** PASS · **Category:** RPC · **Duration:** 2586ms

Uses eth_estimateGas with an authorizationList payload and delegated calldata to verify that provider-side simulation works before broadcast.

**Assertions**

- [x] Provider returns a positive gas estimate
  - expected: `> 0`
  - actual: `71594`
- [x] Estimate exceeds a plain 21k transfer
  - expected: `> 21000`
  - actual: `71594`

**Evidence**

- authority: `0xb8a7DA7c7dC2c1Bbb1F769F9B8872E644126AC22`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- signedAuthorization: `0xf85d83088bb0943086b6c8f25bb5d05840543e5013e8a0c8a2610a8080a082ff91293662fda9dc14a929b6ca2bb7fa5203a224c3aec96255b3bdb4de3200a0514575e7e5604e3a8e2772ea81c9fa40c8d03d3b8170dd0203609ee7b3512074`
- authorizationListEntry:
  chainId: 0x088bb0
  address: 0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a
  nonce: 0x0
  yParity: 0x0
  r: 0x82ff91293662fda9dc14a929b6ca2bb7fa5203a224c3aec96255b3bdb4de3200
  s: 0x514575e7e5604e3a8e2772ea81c9fa40c8d03d3b8170dd0203609ee7b3512074
- calldata: `0x3fb5c1cb000000000000000000000000000000000000000000000000000000000000002a`
- estimate: `71594`
- estimateHex: `0x117aa`

#### `rpc.eth_call_simulates_delegated_context`

**Status:** PASS · **Category:** RPC · **Duration:** 518ms

Uses eth_call with an authorizationList payload against a clean authority and checks that delegated execution resolves address(this) to the authority.

**Assertions**

- [x] Delegated eth_call returns the authority as address(this)
  - expected: `0x4a644d3b319697fe0e646cb9f32a04f1cae22506`
  - actual: `0x4a644d3b319697fe0e646cb9f32a04f1cae22506`

**Evidence**

- authority: `0x4A644D3b319697Fe0e646cb9F32a04f1cAE22506`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- signedAuthorization: `0xf85d83088bb0943086b6c8f25bb5d05840543e5013e8a0c8a2610a8001a0d25a4e47d471ee18db5aa94c33bfb4ea6194d0b360e476c0bd6ec1e7666d8f96a06c9047160f4cc86b4a828d220a20b7b4f7c6a145cfdd8d18445d5719c02abad5`
- authorizationListEntry:
  chainId: 0x088bb0
  address: 0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a
  nonce: 0x0
  yParity: 0x01
  r: 0xd25a4e47d471ee18db5aa94c33bfb4ea6194d0b360e476c0bd6ec1e7666d8f96
  s: 0x6c9047160f4cc86b4a828d220a20b7b4f7c6a145cfdd8d18445d5719c02abad5
- calldata: `0x4a5a8a3b`
- rawResult: `0x0000000000000000000000004a644d3b319697fe0e646cb9f32a04f1cae22506`
- resolvedContext: `0x4a644d3b319697fe0e646cb9f32a04f1cae22506`

#### `rpc.eth_call_surfaces_revert_metadata`

**Status:** PASS · **Category:** RPC · **Duration:** 616ms

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

- authority: `0x1AdD7b6f3521B19cECDE60A8D1bcEA3DEd3b2C8F`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- signedAuthorization: `0xf85d83088bb0943086b6c8f25bb5d05840543e5013e8a0c8a2610a8001a07fc5bdce42080e911d462688c38d9675e9524509d650dd45389136b3992bf762a00c2f899bbb1a6244f001e6204c28958233d234bb522959c280acb6122d2436a0`
- authorizationListEntry:
  chainId: 0x088bb0
  address: 0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a
  nonce: 0x0
  yParity: 0x01
  r: 0x7fc5bdce42080e911d462688c38d9675e9524509d650dd45389136b3992bf762
  s: 0x0c2f899bbb1a6244f001e6204c28958233d234bb522959c280acb6122d2436a0
- calldata: `0x975af67a`
- errorCode: `3`
- errorMessage: `eth_call failed [3]: execution reverted: EXPECTED_REVERT`
- errorData: `0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f45585045435445445f5245564552540000000000000000000000000000000000`

### Authorization

#### `authorization.skips_invalid_chain_id`

**Status:** PASS · **Category:** Authorization · **Duration:** 11176ms

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

- transactionHash: `0x6647847b1c51792bd6b6c618c9ce1cc21f2454a4cbea0bfb1b43b8a52e17c0ce`
- authority: `0x2D2E0B6886112FC1CD66dAE3dE2a69D4F08eF4da`
- attemptedDelegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- code: `0x`

#### `authorization.skips_invalid_nonce`

**Status:** PASS · **Category:** Authorization · **Duration:** 10069ms

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

- transactionHash: `0xe6adfef5123b64c059a401379a55024494282c7f2a257edb8a033ef2617b4c5b`
- authority: `0x31c3b4BA1dCa626cEf3Db33F215509FD1F995D07`
- attemptedDelegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- attemptedNonce: `99`
- code: `0x`

#### `authorization.accepts_chain_id_zero_for_any_chain`

**Status:** PASS · **Category:** Authorization · **Duration:** 14321ms

Signs an authorization with chain_id=0 (chain-agnostic per EIP-7702) and verifies it is accepted on the target chain with the expected delegation side effects.

**Assertions**

- [x] Transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Delegation indicator is written despite chain_id=0
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- [x] Authority nonce increments for the replay-safe authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0x2aa84078ed63dc3bba1ec7fb11005c8ba9e3453284113191a99958d4bdfa3c9a`
- authority: `0x59a5a260D6230cf07683A2026dBbD7bb0D080D6a`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- authorization: `0xf85a80943086b6c8f25bb5d05840543e5013e8a0c8a2610a8080a03f3f6dcbeeb06d28b7474ef7db17feaac4d6cfdf85bedb90644703bb8999d213a019b45fe734ec2a0c769fec2bc75b5354bbeac3da327ddf8f5130d454f5bf9a06`
- code: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`

#### `authorization.overwrites_existing_delegation`

**Status:** PASS · **Category:** Authorization · **Duration:** 45393ms

Delegates an authority to the fixture contract, then re-delegates the same authority to a different target and verifies the indicator swaps while the nonce increments twice.

**Assertions**

- [x] First delegation transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] First indicator points at the fixture
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
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

- authority: `0xE83FB65CBE4Cf16a91Ee11C75F648Dd5c32E3e9d`
- firstTransactionHash: `0xde421194fcbc10729c13170bffb5fda56336c0df08b15c0353b3ec15d0c17f88`
- secondTransactionHash: `0x50149f66c66b5a938f55ff63c74f7e32925aaf0f3b9d026ff18b52a94986ddc1`
- firstDelegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- secondDelegateAddress: `0x0000000000000000000000000000000000000001`
- firstCode: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- secondCode: `0xef01000000000000000000000000000000000000000001`

#### `authorization.clears_with_zero_address`

**Status:** PASS · **Category:** Authorization · **Duration:** 60333ms

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

- initialTransactionHash: `0xbd50aa3f18e004766c0bb1d0feaf3caac08f6a7a37f04931833691a23dd6f37e`
- clearingTransactionHash: `0xf117cdf4964c67342484c7b6ac877ed8d4a946fec7a9d5bab3731b1d0d6f3e82`
- authority: `0x4b8DfC1f98386cf6a6D05dCc607c887f72d0df5d`
- code: `0x`

#### `authorization.writes_contract_delegate_indicator`

**Status:** PASS · **Category:** Authorization · **Duration:** 11909ms

Applies a valid authorization that points to the deployed fixture contract and verifies that the indicator and nonce update match the expected contract delegation path.

**Assertions**

- [x] Contract-target authorization transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Indicator points at the deployed fixture contract
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- [x] Authority nonce increments once for the valid authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0xf0a0107b76c1895f2a31094725252a2669c68fcec920b25cb955967fd0c7cac1`
- authority: `0x822842765404f1F385728BA7813d596eB7d55098`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- code: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`

### Execution

#### `execution.delegated_storage_write`

**Status:** PASS · **Category:** Execution · **Duration:** 16455ms

Delegates an authority to the fixture contract, writes storage through the delegated entrypoint, and reads it back from the authority address.

**Assertions**

- [x] Delegated storage write transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] Authority storage reflects the delegated write
  - expected: `42`
  - actual: `42`
- [x] address(this) resolves to the authority during delegated execution
  - expected: `0x50633baec930e79b1a7406a9d8c71ccc7d5ae58f`
  - actual: `0x50633baec930e79b1a7406a9d8c71ccc7d5ae58f`

**Evidence**

- transactionHash: `0x68bebe138fb27e59deb0dffc1efb0b9fdf76e0c8a9cd6476c95524cd6b41de56`
- authority: `0x50633Baec930E79b1A7406a9d8c71cCc7d5ae58f`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- storedNumber: `42`
- contextAddress: `0x50633baec930e79b1a7406a9d8c71ccc7d5ae58f`

#### `execution.delegation_persists_after_revert`

**Status:** PASS · **Category:** Execution · **Duration:** 7269ms

Delegates an authority and immediately calls a reverting function through the delegated code path to confirm the code write survives a failed execution.

**Assertions**

- [x] Outer execution reverts
  - expected: `0x0`
  - actual: `0x0`
- [x] Delegation indicator still persists
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- [x] Authority nonce still increments for the valid authorization
  - expected: `1`
  - actual: `1`

**Evidence**

- transactionHash: `0xa8875e5a76129a4e6034fca8927087a976fe851d50ecbba489616eba0a2c1c75`
- authority: `0x169EeE1Cd88d135f1932eC48Fb3736f6bFC899D5`
- code: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`

#### `execution.codesize_vs_extcodesize`

**Status:** PASS · **Category:** Execution · **Duration:** 12288ms

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
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`

**Evidence**

- setupTransactionHash: `0x9ae6f9e0b66ead9069dae12db59e89f74ce85a9081b523edb049ea41e6b86f8e`
- authority: `0x681C3B53c486c309677Fd14388F250fA486F7AC4`
- runtimeCodeSize: `449`
- authorityExtCodeSize: `23`
- code: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`

### Security

#### `security.unsafe_initializer_can_be_frontrun`

**Status:** PASS · **Category:** Security · **Duration:** 27646ms

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
  - expected: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
  - actual: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`

**Evidence**

- authority: `0x1921398392C6D7207DD91dD8125189ACd9aEDDa1`
- unsafeInitializerDelegate: `0xf52f301da2b96b642edc8c0cee1c5a45d7e3f3d4`
- delegationTransactionHash: `0x7a11c753ae5f1918fd01dd72f26de5d5a86a689a2812d67122dbefd2e2825717`
- attackerTransactionHash: `0x643c01d0d674e4b5b870923b24f13fdc4793d38d760734ef7a901c0c346a6d3b`
- attacker: `0x5508532b027D57b020e6C0BeDB1fE19a6d6C555c`
- observedOwner: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
- observedInitialized: `1`
- note: `The sponsor races the authority's legitimate initializer and wins; any delegate without access control on initializer-style methods is exploitable post-delegation.`

#### `security.tx_origin_differs_from_authority`

**Status:** PASS · **Category:** Security · **Duration:** 7512ms

Delegates an authority to a TxOriginSensor contract and submits a sponsor-signed type-0x04 call to observe(). The sensor stores tx.origin/msg.sender/address(this) in authority storage so the test can prove tx.origin resolves to the sponsor (breaking any dApp-side "tx.origin == expected user" check).

**Assertions**

- [x] Delegated observe() transaction succeeds
  - expected: `0x1`
  - actual: `0x1`
- [x] tx.origin resolves to the sponsor (not the authority)
  - expected: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
  - actual: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
- [x] msg.sender at the entrypoint is the sponsor (top-level call from sponsor EOA)
  - expected: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
  - actual: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
- [x] address(this) during delegated execution is the authority
  - expected: `0x8dbe48fdd5a7ba953e4cb6ef0881f669590074f4`
  - actual: `0x8dbe48fdd5a7ba953e4cb6ef0881f669590074f4`

**Evidence**

- authority: `0x8DBE48fDD5A7bA953E4cb6EF0881f669590074F4`
- sponsor: `0x5508532b027D57b020e6C0BeDB1fE19a6d6C555c`
- txOriginSensorDelegate: `0xe9850562476e7cbcf3d825ae794ec4bc5b48f378`
- transactionHash: `0x45ffeb61977755104158d3417c657c5f0400f22993f2aa3b8b0b191d597ffdcd`
- observedOrigin: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
- observedSender: `0x5508532b027d57b020e6c0bedb1fe19a6d6c555c`
- observedSelf: `0x8dbe48fdd5a7ba953e4cb6ef0881f669590074f4`
- note: `EIP-7702 does not change tx.origin semantics: the sponsor signing the outer transaction is tx.origin. Delegates that rely on tx.origin for authorization treat sponsored flows as the sponsor, not the authority.`

#### `security.storage_persists_across_redelegations`

**Status:** PASS · **Category:** Security · **Duration:** 40718ms

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
  - expected: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
  - actual: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- [x] Previously written storage value survives the clear/re-delegation cycle
  - expected: `424242`
  - actual: `424242`
- [x] Authority nonce increments three times across the cycle
  - expected: `3`
  - actual: `3`

**Evidence**

- authority: `0x80c713337E06321136026EB16B21d389C1f28E79`
- delegateAddress: `0x3086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- writeTransactionHash: `0x724ed6c34b8165ff2a702efcd7b06ffeccad230871805495bc8d34246d3526a5`
- clearTransactionHash: `0xd1049082c15380043356533a8da2615f8a55fea341360ece2b99f666ca94ce29`
- redelegationTransactionHash: `0xca0b18a022416204d6604ad900700b86c4222ff770b8df08b6d1b3a96896aa6a`
- writeValue: `424242`
- observedStoredNumber: `424242`
- codeAfterClear: `0x`
- codeAfterRedelegation: `0xef01003086b6c8f25bb5d05840543e5013e8a0c8a2610a`
- note: `Storage is keyed by the authority address, not by the delegate's code hash. A new delegate inherits whatever storage the authority already holds, so delegates that assume "fresh state" at any slot can be misled after a re-delegation.`

## Notes

- This run uses real raw transaction signing plus JSON-RPC submission rather than mocked transport behavior.
- The fixture contract is deployed fresh per target so each run has isolated execution evidence.
- The report format is designed to extend toward wallet adapters, relayers, and multi-provider CI publishing.
- Target config source: targets/hoodi.local.json
