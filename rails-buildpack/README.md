# Rails buildpack

rails-buildpack image includes common dependencies required for a rails application.
You can use `rails-buildpack` for your CI or builder of a multi-stage build.

# Older buildpacks

Here is a list of buildpacks with older versions of Ruby:

```ruby
public.ecr.aws/degica/rails-buildpack:2.7
public.ecr.aws/degica/rails-buildpack:2.7.3
public.ecr.aws/degica/rails-buildpack:2.7.5
public.ecr.aws/degica/rails-buildpack:2.7.7
public.ecr.aws/degica/rails-buildpack:3.0
public.ecr.aws/degica/rails-buildpack:3.1
public.ecr.aws/degica/rails-buildpack:3.1.4
public.ecr.aws/degica/rails-buildpack:3.2.1
public.ecr.aws/degica/rails-buildpack:3.2.2
public.ecr.aws/degica/rails-buildpack:3.2.3
public.ecr.aws/degica/rails-buildpack:3.2.4
```

Additional older buildpacks can be found at https://gallery.ecr.aws/degica/rails-buildpack

## multi-stage example

```
FROM degica/rails-buildpack:2.6 AS builder

COPY Gemfile $APP_HOME/
COPY Gemfile.lock $APP_HOME/
RUN bundle install --without development test

ADD package.json $APP_HOME/
ADD yarn.lock $APP_HOME/
RUN yarn

ADD . $APP_HOME

RUN bundle exec rake assets:precompile RAILS_ENV=production


FROM degica/rails-base:2.6

ENV APP_HOME=/app

RUN useradd --user-group app
RUN mkdir -p $APP_HOME && chown -R app:app $APP_HOME
WORKDIR $APP_HOME

COPY --from=builder /usr/local/bundle /usr/local/bundle
ADD --chown=app:app . $APP_HOME
COPY --from=builder --chown=app:app public/assets public/assets

USER app
```
