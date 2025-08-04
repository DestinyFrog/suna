<script lang="ts">
    import { onMount } from "svelte";
    import WindowPeriodicTable from "./lib/WindowPeriodicTable.svelte";
    import { invokeWindow } from "./Window";

    onMount(() =>
        invokeWindow("Tabela Periódica", WindowPeriodicTable))
</script>

<main id="target"></main>
