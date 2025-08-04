<script lang="ts">
    import type { Element } from "./Element";
    import { capitalize, treatCategory } from "./util";

    let {
        element
    } : {
        element: Element
    } = $props()
</script>

<div class="element { treatCategory(element.category) }">
    <p class="atomic-number">{ element.atomic_number }</p>
    <p class="symbol">{ element.symbol }</p>
    <p class="name">{ capitalize(element.oficial_name) }</p>
    <p class="atomic-mass">{ element.atomic_mass } u</p>

    {#snippet layers(element:Element)}
        {@const layers = JSON.parse(element.layers) as number[]}
    
        <ul class="layers">
            {#each layers as layer}
                <li>{ layer }</li>
            {/each}
        </ul>
    {/snippet}

    {@render layers(element)}
</div>

<style scoped lang="scss">
.element {
    position: relative;
    display: flex;
    flex-direction: column;

    min-width: 140px;
    min-height: 140px;
    padding: 6px;

    color: white;

    .symbol {
        font-size: 36px;
        text-align: center;
        margin: 14px 0px;
        font-weight: bolder;
    }

    .name {
        text-align: center;
        margin-bottom: 8px;
    }

    .atomic-mass {
        text-align: center;
    }

    .layers {
        list-style: none;
        position: absolute;
        right: 0;
        text-align: right;
        margin: 4px;
    }
}
</style>