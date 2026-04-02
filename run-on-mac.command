#!/usr/bin/env zsh
cd $(dirname -- "$0")

ruby_cmd="$(which ruby)"
if [[ -z "${ruby_cmd}" ]]; then
    1>&2 echo "WARN: ruby not found"
else
    ${ruby_cmd} -run -e httpd www -p 8000 &
    ruby_pid=$!
    echo "Ruby web server started with PID ${ruby_pid}"
    trap "echo Stopping Ruby web server with PID ${ruby_pid}; kill -9 ${ruby_pid}" INT TERM
    open "http://localhost:8000"
    echo "Waiting for Ruby web server to exit..."
    wait "${ruby_pid}"
    echo "Ruby web server exited"
    exit 0
fi

python_cmd="$(which python3)"
if [[ -z "${python_cmd}" ]]; then
    1>&2 echo "WARN: python3 not found"
else
    ${python_cmd} -m http.server -d www 8000 &
    python_pid=$!
    echo "Python web server started with PID ${python_pid}"
    trap "echo Stopping Python web server with PID ${python_pid}; kill -9 ${python_pid}" INT TERM
    open "http://localhost:8000"
    echo "Waiting for Python web server to exit..."
    wait "${python_pid}"
    echo "Python web server exited"
    exit 0
fi


1>&2 echo "ERROR: no suitable command found to start a web server"
exit 1
