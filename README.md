Error raised
============

```
[pid: 58792|app: 0|req: 56/98] 127.0.0.1 () {28 vars in 314 bytes} [Mon May 16 19:43:39 2016] GET /admin/ => generated 0 bytes in 0 msecs (HTTP/1.1 500) 0 headers in 0 bytes (0 switches on core 1)
SystemError: /Users/sysadmin/build/v3.5.1/Objects/tupleobject.c:156: bad argument to internal function

During handling of the above exception, another exception occurred:

SystemError: <class 'newrelic.common.object_wrapper._NRBoundFunctionWrapper'> returned a result with an error set
```

Steps to reproduce
==================

This guide has been made on Mac.

Setup
-----

Run `./install_python3.sh` in the root folder of this repo.

This will install and run the app.
You should see the log of uWSGI printing in the terminal:

```
*** Starting uWSGI 2.0.13.1 (64bit) on [Mon May 16 21:33:04 2016] ***
compiled with version: 4.2.1 Compatible Apple LLVM 7.3.0 (clang-703.0.29) on 16 May 2016 21:24:08
os: Darwin-15.4.0 Darwin Kernel Version 15.4.0: Fri Feb 26 22:08:05 PST 2016; root:xnu-3248.40.184~3/RELEASE_X86_64
nodename: macbook-air-ben.home
machine: x86_64
clock source: unix
pcre jit disabled
detected number of CPU cores: 4
your processes number limit is 709
your memory page size is 4096 bytes
 *** WARNING: you have enabled harakiri without post buffering. Slow upload could be rejected on post-unbuffered webservers *** 
detected max file descriptor number: 256
lock engine: OSX spinlocks
thunder lock: disabled (you can enable it with --thunder-lock)
uWSGI http bound on 127.0.0.1:3031 fd 4
uwsgi socket 0 bound to TCP address 127.0.0.1:63488 (port auto-assigned) fd 3
Python version: 3.5.1 (v3.5.1:37a07cee5969, Dec  5 2015, 21:12:44)  [GCC 4.2.1 (Apple Inc. build 5666) (dot 3)]
PEP 405 virtualenv detected: ../venv/
Set PythonHome to ../venv/
Python main interpreter initialized at 0x7ff072e00bc0
python threads support enabled
your server socket listen backlog is limited to 100 connections
your mercy for graceful operations on workers is 60 seconds
mapped 701920 bytes (685 KB) for 8 cores
*** Operational MODE: preforking+threaded ***
added ../ to pythonpath.
WSGI app 0 (mountpoint='') ready in 0 seconds on interpreter 0x7ff072e00bc0 pid: 56347 (default app)
spawned uWSGI master process (pid: 56347)
spawned uWSGI worker 1 (pid: 56348, cores: 2)
spawned uWSGI worker 2 (pid: 56349, cores: 2)
spawned uWSGI worker 3 (pid: 56350, cores: 2)
spawned uWSGI worker 4 (pid: 56351, cores: 2)
```

Open a terminal and check the logs of NewRelic python agent `less +F /tmp/python_agent.log`.

Stress the application
----------------------

Poke the admin url of Django twice per second:

`watch -n 0.5 curl http://127.0.0.1:3031/admin/`

You should see and error poping in the uWSGI terminal. If not, stop and re-rerun uwsgi until it shows up.
