<img src="https://openwrt.org/_media/logo.png" alt="logo" width="274" height="84" align="right">

# OpenWrt��Ŀ

�����Ŀfork��[OpenWrt](https://github.com/openwrt/openwrt)

Ĭ�ϵ�¼��ַ: http://172.16.0.1, �û���: __root__, ����: ��.

## ��α����Լ���Ҫ�� OpenWrt �̼�

### ���ٿ�ʼ

1. ִ������ `git clone -b <branch> --single-branch https://github.com/SandroDickens/openwrt.git` ����Դ��.
2. ִ������ `cd openwrt` ����Դ��Ŀ¼.
3. ִ������ `./scripts/feeds update -a` ��ȡfeeds.conf / feeds.conf.default�ж�������µİ�.
4. ִ������ `./scripts/feeds install -a` to install symlinks for all obtained packages into package/feeds/
5. ִ������ `make menuconfig` ѡ������Ҫ��toolchain, target system��firmware�����������ļ�.
6. ִ������ `make download -j$(nproc) V=sc` ����Դ�롢������빤������Linux�ں˵�(��Ҫ�ܷ��ʹ��ʻ�����, �˹��̿��ܻ��в����ļ�����ʧ��, Ϊ����������ִ��2��).
7. ִ������ `make -j$(nproc) V=sc` ����̼�.

## License

OpenWrt is licensed under GPL-2.0
