<script lang="ts">
    import WindowPeriodicTable from "./lib/WindowPeriodicTable.svelte";
    import { invokeWindow } from "./Window";
    import Icon from "./lib/Icon.svelte";
    import IconPeriodicTable from "./icons/icon_periodic_table.svg"    
</script>


<main id="target">
    <Icon title="Tabela Periódica" icon={IconPeriodicTable}
        onclick={() => invokeWindow("Tabela Periódica", WindowPeriodicTable)}/>
</main>

<style>
    #target {
        width: 100vw;
        height: 100vh;
    }
</style>