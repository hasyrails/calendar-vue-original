<template>
  <div class="confirm">
    <div>ご入力内容</div>
		<div class="flex-contents">
		  <div class="confirm-contents">
		    <div>ユーザー名: {{ form.name }} </div>
		    <div>メールアドレス: {{ form.email }}</div>
		    <div>パスワード: {{ form.password }}</div>
		    <div>パスワード（確認）: {{ form.password_confirmation }}</div>
		  </div>
		  <div class="btn btn-green register-btn" @click="register">登録する</div>
		</div>
  </div>
</template>

<script>
export default {
  name: 'ConfirmForm',
  props:{
		form: Object
  },
  methods:{
    register(){
      this.$emit('clickedRegisterButton', this.form)
    }
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
	width: 20%;
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
