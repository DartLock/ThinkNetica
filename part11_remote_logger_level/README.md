# Part10Docker

### Before start server

  * Run `mix setup` to install and setup dependencies

### START Phoenix server on localhost

To start your Phoenix server:

  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### START Phoenix server from release

* Run `PHX_SERVER=true _build/dev/rel/part10_docker/bin/part10_docker start`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Helpful commands

* `mix release.init`
Prelease configurations.
This it creates `rel` directory with required configs.

* `mix release`
This is command copying files from `rel` to `_build/ENV/rel`.
After this is available for starts release server.

* Run `_build/dev/rel/part10_docker/bin/part10_docker` for listr all available commands
```
The known commands are:

    start          Starts the system
    start_iex      Starts the system with IEx attached
    daemon         Starts the system as a daemon
    daemon_iex     Starts the system as a daemon with IEx attached
    eval "EXPR"    Executes the given expression on a new, non-booted system
    rpc "EXPR"     Executes the given expression remotely on the running system
    remote         Connects to the running system via a remote shell
    restart        Restarts the running system via a remote command
    stop           Stops the running system via a remote command
    pid            Prints the operating system PID of the running system via a remote command
    version        Prints the release name and version to be booted
```
