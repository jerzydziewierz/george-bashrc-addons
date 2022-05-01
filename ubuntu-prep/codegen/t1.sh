curl -X 'POST' \
  'http://34.90.58.134:8080/complete' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "prompt": "Donald Trump was",
  "length": 128,
  "top_p": 1,
  "temperature": 1
}'
