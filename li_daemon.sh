function daemon_pid() {

  PID_FILE=$1
  if [ -z "$PID_FILE" ]; then
    echo "PID_FILE 未指定"
    exit 2
  fi

  # 检测守护进程是否存在
  if [ -f "$PID_FILE" ]; then
    PID="$(cat $PID_FILE)"
    if kill -0 "$PID" 2>/dev/null; then
      echo "守护进程${PID}已经在运行"
      exit 1
    else
      echo "守护进程${PID}未启动，删除${PID_FILE}"
      rm "$PID_FILE"
    fi
  fi
  echo $$ > "$PID_FILE"
}
