<template>
  <div class="confirm">
    <div>ご入力内容</div>
		<div class="flex-contents">
		  <div class="confirm-contents">
		    <div>ユーザー名: {{ form.userName }} {{ form.lastName }}</div>
		    <div>メールアドレス: {{ form.email }}</div>
		    <div>パスワード: {{ form.password }}</div>
		    <div>パスワード（確認）: {{ form.passwordConfirmation }}</div>
		  </div>
		  <div class="btn btn-green register-btn">登録する</div>
		</div>
  </div>
</template>

<script>
export default {
  name: 'ConfirmForm',
  props:{
		form: Object
	}
}
</script>

<style scoped>
.confirm{
	font-size: 30px;
	/* text-align: center; */
}

.flex-contents{
	display: flex;
}

.confirm-contents{
	margin-left: 1%;
	margin-top: 1%;
}
.register-btn,
.register-btn.disabled, .register-btn:disabled{
	font-size: 25px;
	height: 50px;
	width: 10%;
	margin-left: 30%;
	margin-top: 3%;
	border-radius: 30px 30px 30px 30px;
	text-align: center;
	color: grey;
  background-color: #00FFCC;
  border-color: #00FFCC;
}

.register-btn:hover {
  color: black;
  background-color: #00FF99;
  border-color: #00FF99;
}
</style>
