function daemon_pid() {

  PID=$1
  if [ -z "$PID" ]; then
    echo "PID 未指定"
    eixt 2
  fi

  # 检测守护进程是否存在
  if [ -f "$PID" ]; then
    if kill -0 "$(cat "$PID")" 2>/dev/null; then
      echo "守护进程已经存在"
      exit 1
    else
      echo "守护进程已经失效，删除PID"
      rm "$PID"
    fi
  fi
}
