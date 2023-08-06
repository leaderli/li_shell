# 将当前进程标记为守护进程，并将PID保存
# 参数：$1 保持守护进程PID的文件
function start_daemon_by_pid_file() {

  PID_FILE=$1
  if [ -z "$PID_FILE" ]; then
    echo "PID_FILE 未指定"
    exit 2
  fi

  # 检测守护进程是否存在
  if [ -f "$PID_FILE" ]; then
    PID="$(cat "$PID_FILE")"
    if kill -0 "$PID" 2>/dev/null; then
      echo "守护进程${PID}已经在运行"
      exit 1
    else
      echo "守护进程${PID}未启动，删除${PID_FILE}"
      rm "$PID_FILE"
    fi
  fi
  echo $$ >"$PID_FILE"
}
# 根据PID终止守护进程的执行
# 参数：$1 保持守护进程PID的文件
function stop_daemon_by_pid_file() {

  PID_FILE=$1
  if [ -z "$PID_FILE" ]; then
    echo "PID_FILE 未指定"
    exit 2
  fi
  # 检测守护进程是否存在
  if [ -f "$PID_FILE" ]; then
    PID="$(cat "$PID_FILE")"
    echo "kill 守护进程${PID}"
    kill -9 "$PID" 2>/dev/null
    rm "$PID_FILE"
  fi
}
