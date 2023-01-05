<template>
  <div class="absolute w-full bg-teal-500 text-white py-1 top-0 mt-0">
    <div class="container mx-auto px-4">
      <div class="flex -mx-4">
        <div class="w-full text-center">
          <p class="text-xs md:text-sm">Split Treatment: {{ treatment }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex'
export default {
  computed: {
    ...mapState(['treatment'])
  }
}
</script>