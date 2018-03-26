FROM elixir:1.6.0

ENV APP=/home
WORKDIR $APP

COPY . $APP

RUN mix local.hex --force
RUN mix deps.get
RUN yes | mix compile
