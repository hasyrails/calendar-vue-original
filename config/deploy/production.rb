# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '18.178.224.137', user: 'hasyrails', roles: %w{app db web} 

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/calendar-vue-original_key_rsa' 
