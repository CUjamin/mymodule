# Version 1.1.19

* Add checks for empty string (Paweł Chmielowski)
* Remove unused code (Paweł Chmielowski)
* Load locally build .so file when performing tests (Paweł Chmielowski)

# Version 1.1.18

* Use p1_utils 1.0.6 (Paweł Chmielowski)
* fix xref with otp 17 (Paweł Chmielowski)

# Version 1.1.17

* Add 'undefined' type to some record fields type specs (Evgeniy Khramtsov)

# Version 1.1.16

* Improve XML generator (Evgeniy Khramtsov)

# Version 1.1.15

* Update to p1_utils 1.0.5 (Mickaël Rémond)

# Version 1.1.14

* Erlang OTP R19 compliance (Paweł Chmielowski)
* Fix compilation on rebar3 (Paweł Chmielowski)

# Version 1.1.13

* Use p1_utils 1.0.4 (Mickaël Rémond)

# Version 1.1.12

* Generator improvements (Evgeny Khramtsov)

# Version 1.1.11

* Now properly includes Elixir lib/ directory in hex.pm package (Mickaël Rémond)

# Version 1.1.10

* Split build in two steps to fix link step on Ubuntu (Paweł Chmielowski - Mickaël Rémond)
* Clean Makefile.mix to remove duplicated code (Paweł Chmielowski)

# Version 1.1.9

* Fix Linux build with Mix (Paweł Chmielowski)

# Version 1.1.8

* Package priv/lib structure to make sure everything is properly build by mix (Mickaël Rémond)

# Version 1.1.7

* Fix indent issue in Mix Makefile (Mickaël Rémond)

# Version 1.1.6

* Add missing Makefile.mix file in rebar hex.pm package description (Mickaël Rémond)
* Make sure priv dir is created when building with mix and included in package dir list (Mickaël Rémond)

# Version 1.1.4

This is an Elixir friendly update:

* Add ability to return maps instead of xmlel record (Paweł Chmielowski)
* Add ability to tell parser to return Elixir structs instead of records (Mickaël Rémond)
* Add Elixir tests (Mickaël Rémond)

# Version 1.1.3

* Memory optimizations (Paweł Chmielowski)
* Update to latest version of p1_utils (Mickaël Rémond)
* Erlang OTP R18 compliance (Evgeniy Khramtsov)

# Version 1.1.2

* Application is now called fast_xml (Mickaël Rémond)

# Version 1.1.1

* Support for both rebar and rebar3 (Mickaël Rémond)
* Huge performance and memory improvements (Paweł Chmielowski)
* Normalize namespace prefixed elements (Paweł Chmielowski)
* Document how to run tests (Mickaël Rémond)
* Architecture documentation in README.md (Mickaël Rémond)
* Introduce Elixir Quickcheck tests (Mickaël Rémond)
* Support C code coverage (Paweł Chmielowski)
* Better test case coverage (Evgeniy Khramtsov)
* Continuous integration with Travis CI and Coveralls (Paweł Chmielowski - Mickaël Rémond)
* Test refactoring (Evgeniy Khramtsov)
* Save cflags/ldflags passed to configure (Paweł Chmielowski)
* Move code for locating nif files to p1_utils package (Paweł Chmielowski)
* Improve code for locating .so part (Paweł Chmielowski)
* Do not check Expat presence via m4 macro (Evgeniy Khramtsov)

# Version 1.1.0

* Initial release on Hex.pm (Mickaël Rémond)
