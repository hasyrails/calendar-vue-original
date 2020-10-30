<template>
<div class="not-found">
  <div class="not-found-error">404 Not Found</div>
  <div class="error-message">お探しのページは見つかりませんでした</div>
  <div class="icon marquee-anima"><EmoticonCryOutline :size="200" fillColor="#87CEFA"></EmoticonCryOutline></div>
</div>
</template>

<script>
import EmoticonCryOutline from 'vue-material-design-icons/EmoticonCryOutline.vue';

export default{
  name: 'NotFound',
  components:{
    EmoticonCryOutline
  }
} 
</script>

<style scoped>
.not-found{
  width: 100vw;
}
.not-found-error{
  position: fixed;
  top:30%;
  left:45%;
  font-size:50px;
}
.error-message{
  position: fixed;
  top:40%;
  left:35%;
  font-size:50px;
}
.icon{
  position: fixed;
  top:50%;
  left:47%;
  font-size:50px;
}

.marquee-anima {
  overflow: hidden;
  color: rgb(51,51,51); 
}
 
.marquee-anima span {
  display: inline-block;
  padding-left: 100%;
  white-space: nowrap;
  animation: marquee 5s linear infinite;
}
 
@keyframes marquee {
  0% {
    transform: translate(10%);
  }
  50% {
    transform: translate(-120%);
  } 
 100% {
    transform: translate(10%);
  } 
}
</style>
