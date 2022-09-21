# local-dev-tools

## Run Localnet

1. `cp example.env .env`
2. Modify .env file and point to code locations for `sonr` and `sonr-vault`.
3. Run `run-localnet.sh` script
    * To run localnet with latest code changes run the script with `--build` flag.

#### Ex.
```shell
➜ ./run-localnet.sh
[+] Running 4/4
 ⠿ Container localnet-sonr-node0  Started                                     0.3s
 ⠿ Container localnet-ipfs        Started                                     0.3s
 ⠿ Container localnet-sonr-node1  Started                                     0.7s
 ⠿ Container localnet-sonr-vault  Started                                     0.6s
```

