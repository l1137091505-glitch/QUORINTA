# QUORINTA

QUORINTA is an original BOT Chain community voting interface. A contract owner publishes a support-or-oppose question; each wallet may record one paid or free vote before the deadline.

## Included

- Solidity `0.8.24` contract with one-vote-per-wallet enforcement.
- React-free Vite/TypeScript frontend with ethers v6.
- EIP-6963 wallet discovery, explicit wallet chooser and BOT Chain switching.
- Mobile MetaMask deep link and deployed-bytecode verification.
- Preview interface when no contract address is configured.
- Chinese deployment guide for Remix, GitHub and Vercel.

## Local build

```bash
cd frontend
npm install
npm run build
```

Set `VITE_QUORINTA_ADDRESS` to the deployed BOT Chain contract address.

This project is an independent implementation. It does not copy Votaryn code, text, images or signature effects.
