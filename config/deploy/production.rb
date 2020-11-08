# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '0.0.0.0:22', user: 'hasyrails', roles: %w{app db web} 

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/id_rsa' 
