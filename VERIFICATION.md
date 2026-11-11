# Verification

- `npm run build` must complete successfully in `frontend`.
- `Quorinta.sol` must compile with Solidity `0.8.24`.
- BOT Chain RPC must return chain ID `0x2a5` (677).
- Production requires `VITE_QUORINTA_ADDRESS`.
- The frontend checks deployed bytecode before any write transaction.
- Test owner publishing and a second-wallet vote with a small fee before wider use.
