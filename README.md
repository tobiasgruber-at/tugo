# README

**_TUgo_** is a tool to quickly query people, projects, courses or theses provided by
the [TISS](https://tiss.tuwien.ac.at/)
API.

## Requirements

This project requires [Ruby](https://www.ruby-lang.org) with version `3.3.0`, [Rails](https://rubyonrails.org/) with
version `7.1.2` and [SQLite3](https://www.sqlite.org/) with version `1.4`.

## Getting Started

To initialize this project, run the bundler to install the needed gems:

```shell
bin/bundle install
```

To initialize the database, we use this command:

```shell
bin/rails db:migrate
```

After that, the server can be started via

```shell
bin/rails server
```

## Documentation

_TUgo_ also provides extensive [YARD](https://yardoc.org/) documentation, which can be generated if needed. Simply run
the following command:

```shell
yardoc
```
