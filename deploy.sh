echo '开始执行命令'
git pull

echo "创建虚拟环境"
python3 -m venv ./venv_somesevers

echo "生效虚拟环境"
source ./venv_somesevers/bin/activate

echo "安装依赖"
pip install --upgrade pip
pip install -r requirements/base.txt

echo "杀掉历史进程"
ps axu | grep 'app.main:app'|grep -v 'grep'|awk '{print $2}'|xargs kill -9

echo "启动 app.main:app"
cd src && nohup uvicorn app.main:app --reload >nohup.server 2>&1 &
