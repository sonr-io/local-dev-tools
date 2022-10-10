#!/bin/sh
#!/bin/bash
help()
{
    echo "Usage: $(basename "$0") [ -B | --build-all ]
               [ -b | --build ]
               [ -s | --stop ]
               [ -S | --stop-all ]
               [ -h | --help  ]"
    exit 2
}

needs_arg() { if [ -z "$OPTARG" ]; then echo "No arg for --$OPT option"; exit 2; fi; }


while getopts 'b:s:-:BSh' OPT; do
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
  fi
  case "$OPT" in
    B | build-all ) build_all=1 ;;
    b | build ) needs_arg; build="$OPTARG" ;;
    S | stop-all ) stop_all=1 ;;
    s | stop ) needs_arg; stop="$OPTARG" ;;
    h | help) help ;;
    ??*)
      echo "Unexpected option: --$OPT"
      help
      ;;
    ?) 
      echo "Unexpected option: -$OPT"
      help
      ;;
  esac
done

build=$(echo "$build" | sed 's/,/ /g')
stop=$(echo "$stop" | sed 's/,/ /g')

COMPOSE_FILE="./localnet/docker-compose-localnet.yml"

ENV_FILE=.env
if [ ! -f "$ENV_FILE" ]; then
  echo "$ENV_FILE file doesn't exist"
  echo "Run:         cp example.env .env"
  echo "modify variables in .env, and run this script again."
  exit 0
fi

unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' .env | xargs -0)
fi

if [ "$stop_all" = "1" ]; then
  docker-compose -f $COMPOSE_FILE stop
  exit 0
fi

if [ -n "$stop" ]; then
  docker-compose -f $COMPOSE_FILE stop "$stop"
  exit 0
fi

if [ "$build_all" = "1" ]; then
  docker-compose -f $COMPOSE_FILE build --no-cache
fi

if [ -n "$build" ]; then
  docker-compose -f $COMPOSE_FILE build --no-cache "$build"
fi

docker-compose -f $COMPOSE_FILE up -d
