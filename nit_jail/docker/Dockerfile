FROM nitlang/nit:latest

# Packages needed by the tutorial
RUN apt-get update \
	&& apt-get install -y --no-install-recommends libcaca-dev \
	&& rm -rf /var/lib/apt/lists/*

# Warm-up ccache
RUN nitc examples/hello_world.nit \
	&& rm hello_world
