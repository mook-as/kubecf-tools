#!/usr/bin/env bash

HTTP_EXCEPTIONS=.http_exceptions
if [ -f "${HTTP_EXCEPTIONS}" ]; then
    EXCEPTIONS=$(perl -e 'while(<>){chomp; push @_,quotemeta unless /^#/} print join("|", @_)' < "${HTTP_EXCEPTIONS}")
else
    EXCEPTIONS="127\.0\.0\.1|localhost"
fi

if [ "$(git grep --untracked -P "http://(?!${EXCEPTIONS})" -- ':(exclude)httplint.sh' | wc -l)" -gt 0 ]; then
    echo "URLS should not start with 'http://' (with excepted domains listed in ${HTTP_EXCEPTIONS})"
    git grep --untracked -P "http://(?!${EXCEPTIONS})" -- ':(exclude)httplint.sh'
    exit 1
fi
