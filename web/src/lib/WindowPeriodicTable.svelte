<script lang="ts">
    import { onMount } from 'svelte';
    import { invokeWindow } from '../Window';
    import Element, { type ElementPayload } from './Element';
    import { capitalize, treatCategory } from './util';
    import WindowElement from './WindowElement.svelte';

    function openElement(element: ElementPayload) {
        invokeWindow(capitalize(element.oficial_name), WindowElement, { element })
    }

    let elements = $state([]) as ElementPayload[]

    onMount(() => {
        Element.getAll()
            .then(data => elements = data)
            .catch(console.error)
    })
</script>

<div class="periodic-table">
{#each elements as element}
    <button class="element {treatCategory(element.category)}"
        onclick={() => openElement(element)}
        style="grid-column-start: {element.xpos}; grid-row-start: {element.ypos};">
        {element.symbol}
    </button>
{/each}
</div>

<style scoped>
    .periodic-table {
        display: grid;
        list-style: none;
        margin: 10px;
        gap: 1px;
    }

    .element {
        display: flex;
        align-items: center;
        justify-content: center;
        border: 0;
        
        width: 28px;
        height: 28px;

        color: white;
        font-family: 'Courier New', Courier, monospace;
        font-size: 16px;
        font-weight: 500;
    }
</style>