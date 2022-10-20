#!/bin/sh
#!/bin/bash
help()
{
    echo "Usage: $(basename "$0") [ -B | --build-all ]
               [ -b | --build ]
               [ -s | --stop ]
               [ -S | --stop-all ]
               [ -r | --run ]
               [ -h | --help  ]"
    exit 2
}

needs_arg() { if [ -z "$OPTARG" ]; then echo "No arg for --$OPT option"; exit 2; fi; }


while getopts 'b:r:s:-:BSh' OPT; do
  if [ "$OPT" = "-" ]; then
    OPT="${OPTARG%%=*}"
    OPTARG="${OPTARG#$OPT}"
    OPTARG="${OPTARG#=}"
  fi
  case "$OPT" in
    B | build-all ) build_all=1 ;;
    b | build ) needs_arg; build="$OPTARG" ;;
    S | stop-all ) stop_all=1 ;;
    s | stop ) needs_arg; stop="$OPTARG" ;;
    r | run ) needs_arg; run="$OPTARG" ;;
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
run=$(echo "$run" | sed 's/,/ /g')

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
  echo "$stop" | xargs docker-compose -f $COMPOSE_FILE stop
  exit 0
fi

if [ "$build_all" = "1" ]; then
  docker-compose -f $COMPOSE_FILE build
fi

if [ -n "$build" ]; then
  echo "$build" | xargs docker-compose -f $COMPOSE_FILE build
fi

if [ -n "$run" ]; then
  echo "$run" | xargs docker-compose -f $COMPOSE_FILE up -d
  exit 0
fi

docker-compose -f $COMPOSE_FILE up -d
