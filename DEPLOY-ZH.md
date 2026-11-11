# QUORINTA 部署步骤

## 1. 上传 GitHub

1. 在 GitHub 新建公开仓库 `quorinta`，不要额外创建 README、License 或 `.gitignore`。
2. 解压 `QUORINTA-GITHUB-UPLOAD.zip`。
3. 将解压后的全部内容上传到仓库根目录并提交。

## 2. 在 Remix 部署合约

1. 打开 Remix，在 `contracts` 文件夹中新建 `Quorinta.sol`。
2. 复制独立文件 `Quorinta.sol` 的全部代码，粘贴并保存。
3. 打开 **Solidity Compiler**，编译器选择 `0.8.24`，点击 **Compile Quorinta.sol**。
4. 打开 **Deploy & Run Transactions**。
5. Environment 选择 **Browser Extension / MetaMask**。
6. 确认钱包网络是 BOT Chain Mainnet（Chain ID `677`）。
7. Contract 选择 `Quorinta`，构造函数没有参数，点击 **Deploy**。
8. 钱包确认交易后，复制完整合约地址。

## 3. Vercel 部署前端

1. 在 Vercel 导入刚创建的 GitHub 仓库。
2. Root Directory 选择 `frontend`。
3. Framework Preset 选择 `Vite`。
4. 添加环境变量：

```text
Key: VITE_QUORINTA_ADDRESS
Value: 你刚部署的完整合约地址
Environment: Production
Type: Config
```

5. 点击 Deploy。若先部署了前端再添加变量，请进入 Deployments 重新 Redeploy，且不要使用旧 Build Cache。

## 4. 第一次使用

1. 打开部署后的网页，点击 **Connect wallet**。
2. 选择部署合约时使用的钱包。网页会请求切换到 BOT Chain Mainnet。
3. 滚动到 **Owner desk**。
4. 填写问题、说明、持续小时数、投票费用和费用接收地址。
5. 点击 **Publish ballot**，钱包确认后即生成第一个投票。
6. 其他钱包连接后，可在 Voting workspace 选择 Support 或 Oppose 并提交一次投票。

## 5. BOT Chain 网络参数

```text
Network Name: BOT Chain Mainnet
RPC URL: https://rpc.botchain.ai
Chain ID: 677
Currency Symbol: BOT
Block Explorer: https://scan.botchain.ai
```

合约地址是公开信息，应设为 Config，不能当作 Secret。不要上传钱包私钥或助记词。请先用少量 BOT 测试。
