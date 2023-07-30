#!/bin/bash
# 前情提要
BYellow='\033[1;33m'
NC='\033[0m' # No Color

echo -e "以下即將${BYellow}半自動${NC}安裝中文化語言包，搭配rwfus 的方式讓中文包不會隨更新被洗掉，
在每個步驟結束時都會暫停讓你檢查是否安裝成功，若失敗的話建議回覆原廠預設再重新來過（作者本人就失敗了也是這樣做），
${BYellow}凡事都有風險請量力而為，重要的請先備份${NC}"
echo "有4個步驟，結束時均會暫停請檢查是否成功（success)"
echo "1. 安裝rwfus"
echo "2. 安裝語言包"
echo "3. 安裝翻譯套件"
echo "4. 同步軟體庫"



read -p "若已經了解以上風險，請按Enter 繼續，不行請按Ctrl+C 或工具列編輯（edit）->送出信號(send signal)->中斷工作(interupt INT)"

# 停用 唯讀模式
sudo steamos-readonly disable
# 使用 rwfus
git clone https://github.com/ValShaped/rwfus.git
cd rwfus
sudo sh ./rwfus -iI
read -p "Rwfus 已安裝，請檢查以上Rwfus有沒有安裝成功（success)，有請按Enter,沒有請按Ctrl+C 中止"
# 初始化 Pacman Keys
sudo pacman-key --init
sudo pacman-key --populate archlinux
# 重新安裝 glibc
sudo pacman -S glibc --noconfirm
# 編輯 locale.gen
sudo sed -i "s%#zh_TW.UTF-8 UTF-8%zh_TW.UTF-8 UTF-8%" /etc/locale.gen
# 生成語言
sudo locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 ja_JP.UTF-8 en_US.UTF-8
read -p "語言包已安裝，請檢查以上語言包有沒有安裝成功（success)，有請按Enter,沒有請按Ctrl+C 中止"
#read -p "以下將安裝語言必要程式。
#注意第三步本來就會裝比較久（作者本人就裝了30-40 分鐘），
#各位可以在繼續這一步時去洗澡健身運動打發時間，
#瞭解後請按Enter 繼續，"

# 安裝程式: kde翻譯套件、plasma
read -p "以下安裝桌面翻譯套件，請按Enter繼續"
sudo pacman -S ki18n --noconfirm #中文化桌面環境元件
sudo pacman -S plasma --noconfirm #plasma 桌面
sudo pacman -S kde-system --noconfirm #kde 系統應用安裝中化（重點為dolphin 跟 分割區管理員中文化）
sudo pacman -S kate --noconfirm #內建文字編輯器中文化
sudo pacman -S konsole --noconfirm #終端機中文化
read -p "以下最後同步軟體庫但是不更新，更新是官方的事，能理解請按Enter繼續"
sudo pacman -Sy
# 重新安裝所有程式
#sudo pacman -Qq > packages.txt
#blackPackages=("steam-im-modules steam-jupiter-stable steam_notif_daemon steamdeck-kde-presets steamos-atomupd-client-git steamos-customizations-jupiter steamos-devkit-service steamos-efi steamos-tweak-mtu-probing adobe-source-code-pro-fonts linux-firmware-neptune noto-fonts noto-fonts-cjk qt5-webengine gcc-libs lib32-gcc-libs linux-neptune-61 llvm-libs lib32-llvm-libs git ffmpeg ki18n plasma glibc python python-aiohttp python-aiosignal python-async-timeout python-attrs python-chardet python-charset-normalizer python-click python-crcmod python-evdev python-frozenlist python-gobject python-hid python-idna python-multidict python-progressbar python-psutil python-pyaml python-pyenchant python-pyinotify python-semantic-version python-systemd python-sysv_ipc python-typing_extensions python-utils python-yaml python-yarl")
#for pkgName in $(cat ./packages.txt); do
#        if [[ $blackPackages =~ (^|[[:space:]])$pkgName($|[[:space:]]) ]]; then
#              echo "跳過 $pkgName"
#    else
#              sudo pacman -S $pkgName --noconfirm
#    fi
#done

# 復原唯讀模式
sudo steamos-readonly enable
read -p "請檢查以上程式有沒有安裝成功（success)，有請按Enter,沒有請按Ctrl+C 中止"
# 完成提示語
echo "完成！請重新開機套用修改！"
