# EIP-7702 Compatibility Matrix

- **Suite:** eip-7702-conformance-harness v0.2.0
- **Generated:** 2026-04-22T10:49:44.508Z

## Summary

| Targets | Passing | Failing |
| --- | --- | --- |
| 2 | 2 | 0 |

## Targets

| Target | Kind | Result | Passed | Failed | Report |
| --- | --- | --- | --- | --- | --- |
| hoodi-alchemy | rpc | PASS | 16 | 0 | [markdown](hoodi-alchemy/report.md) |
| local-managed | managed-anvil | PASS | 16 | 0 | [markdown](local-managed/report.md) |

## Notes

- Matrix mode compiles the fixture once and then executes the same test plan against each target sequentially.
- Targets that fail during setup or transport initialization are captured in the matrix index without aborting the remaining runs.
