kubectl proxy --address 0.0.0.0 --accept-hosts .* &$
./ngrok http 8001 > /dev/null &

