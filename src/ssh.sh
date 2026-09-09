#!/usr/bin/expect -f
spawn ./copy.sh

expect -timeout 2 {
  "*fingerprint*" { send -- "yes\r" }
}

for {set i 0} {$i < 4} {incr i} {
  expect {
    "*password*" { send -- "1234\r" }
  }
}

expect eof
