FROM elixir:1.5.2

ENV APP=/home
WORKDIR $APP

COPY . $APP

RUN mix local.hex --force
RUN mix deps.get
RUN yes | mix compile
