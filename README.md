# local-dev-tools

## Run Localnet

1. `cp example.env .env`
2. Modify .env file and point to code locations for `sonr` and `sonr-vault`.
3. Run `run-localnet.sh` script
    * To run localnet with latest code changes run the script with `--build-all` flag.

#### Available Options
1. Run all Containers
```shell
➜ ./run-localnet.sh
[+] Running 4/4
 ⠿ Container localnet-sonr-node0  Started                                     0.3s
 ⠿ Container localnet-ipfs        Started                                     0.3s
 ⠿ Container localnet-sonr-node1  Started                                     0.7s
 ⠿ Container localnet-sonr-vault  Started                                     0.6s
```

2. Build all Containers
```shell
➜ ./run-localnet.sh --build-all
```
Or
```shell
➜ ./run-localnet.sh -B
```

3. Run specific container without building. 
For example run ipfs, vault and a single sonr node.
```shell
➜ ./run-localnet.sh -r ipfs,sonr0,sonr-vault
[+] Running 3/0
 ⠿ Container localnet-ipfs        Running                                                          0.0s
 ⠿ Container localnet-sonr-node0  Running                                                          0.0s
 ⠿ Container localnet-sonr-vault  Running                                                          0.0s
``` 

4. Build and run containers by provinding service name of the container.
```
./run-localnet.sh -b ipfs,sonr0,sonr-vault
``` 

5. Help
```shell
➜ ./run-localnet.sh -h
Usage: run-localnet.sh [ -B | --build-all ]
               [ -b | --build ]
               [ -s | --stop ]
               [ -S | --stop-all ]
               [ -r | --run ]
               [ -h | --help  ]
```

#### Port mapping
Following mappings are based on your localhost. Try `localhost:1317` on your browser and you can access http api console for `sonr0`, similarly try `locahost:1318` for `sonr1`.

1. ipfs:
`4001`,`5001`,`8080`
2. sonr0:
`1317,2345,26656,26657,9090,9091,4500`
3. vault:
`8888`
4. sonr1:
`1318,2346,26666,26667,9092,9093,4501`


Notes:
1. For the most part service combination of `ipfs,sonr0,sonr-vault` will be suffice for single sonr node testing.

