#!/bin/bash
set -e

bin/001_get_list.sh
bin/002_create_hash.pl
bin/003_get_a_side_history.pl
bin/004_post_message.pl
