# local-dev-tools

## Run Localnet

1. `cp example.env .env`
2. Modify .env file and point to code locations for `sonr` and `sonr-vault`.
3. Run `run-localnet.sh` script
    * To run localnet with latest code changes run the script with `--build` flag.

#### Ex.
```shell
➜ ./run-localnet.sh
[+] Running 3/0
 ⠿ Container localnet-ipfs        Created                                  0.0s
 ⠿ Container localnet-sonr-node0  Created                                  0.0s
 ⠿ Container localnet-sonr-vault  Created                                  0.0s
Attaching to localnet-ipfs, localnet-sonr-node0, localnet-sonr-vault
localnet-ipfs        | Changing user to ipfs
localnet-ipfs        | ipfs version 0.15.0
localnet-ipfs        | Found IPFS fs-repo at /data/ipfs
localnet-ipfs        | Initializing daemon...
localnet-ipfs        | Kubo version: 0.15.0-3ae52a4
localnet-ipfs        | Repo version: 12
localnet-ipfs        | System version: arm64/linux
localnet-ipfs        | Golang version: go1.18.5
localnet-sonr-node0  | Cosmos SDK's version is: stargate - v0.45.5
localnet-sonr-node0  |
localnet-sonr-vault  | [WARNING] Chain Validation is disabled.
localnet-sonr-node0  | ▶️  Restarting existing app...
localnet-sonr-node0  | 🌍 Tendermint node: http://0.0.0.0:26657
localnet-sonr-node0  | 🌍 Blockchain API: http://0.0.0.0:1317
localnet-sonr-node0  | 🌍 Token faucet: http://0.0.0.0:4500
localnet-ipfs        | Swarm listening on /ip4/127.0.0.1/tcp/4001
localnet-ipfs        | Swarm listening on /ip4/127.0.0.1/udp/4001/quic
localnet-ipfs        | Swarm listening on /ip4/172.16.238.2/tcp/4001
localnet-ipfs        | Swarm listening on /ip4/172.16.238.2/udp/4001/quic
localnet-ipfs        | Swarm listening on /p2p-circuit
localnet-ipfs        | Swarm announcing /ip4/127.0.0.1/tcp/4001
localnet-ipfs        | Swarm announcing /ip4/127.0.0.1/udp/4001/quic
localnet-ipfs        | Swarm announcing /ip4/172.16.238.2/tcp/4001
localnet-ipfs        | Swarm announcing /ip4/172.16.238.2/udp/4001/quic
localnet-ipfs        | API server listening on /ip4/0.0.0.0/tcp/5001
localnet-ipfs        | WebUI: http://0.0.0.0:5001/webui
localnet-ipfs        | Gateway (readonly) server listening on /ip4/0.0.0.0/tcp/8080
localnet-ipfs        | Daemon is ready
```

