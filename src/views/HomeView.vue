<script lang="ts" setup>
import Terminal from '@/components/TerminalComponent.vue'
</script>

<template>
  <div>
    <h1>Home</h1>
    <button @click="$router.push('/about')">About</button>
    <Terminal />
  </div>
</template>
