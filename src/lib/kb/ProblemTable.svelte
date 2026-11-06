<script lang="ts">
  import reports from '#lib/data/reports-4471.json';
  import notes from '#lib/data/desk-notes.json';
  import { groupByCause, readAs, uniqueById, type Report } from '#lib/kb/causes';
  import { tenantOf } from '#lib/kb/locales';

  // The desk's own view (as CauseTable counts it): each report under the cause its tenant files it
  // under; the one-day moves (desk-notes.json) counted where they're filed and again as their own problem.
  let { ticket, issues = {} }: { ticket: number; issues?: Record<string, string> } = $props();

  const merged = $derived(uniqueById(reports as Report[]).filter((r) => r.mergedInto === ticket));
  const groups = $derived(groupByCause(merged, tenantOf));
  const shift = $derived(merged.filter((r) => notes.oneDayMove.includes(r.id)));
  const days = (rs: Report[]) => rs.map((r) => r.receivedAt.slice(0, 10)).sort();
  const WHAT: Record<string, string> = {
    parser: 'shared parser reads day-first dates month first: day and month swapped',
    hint: 'booking-v3 form hint says MM/DD/YYYY, the form reads the tenant’s day-first order',
    shift: 'date moved by one day (time zone / summer time), not a swap',
    unplaced: 'tenant not on file, or not day-first',
  };
  const rows = $derived([
    ...groups.map((g) => ({ problem: g.cause, n: g.reports.length, tenants: g.tenants, first: g.firstSeen, last: g.lastSeen, also: readAs(g, notes.oneDayMove) })),
    { problem: 'shift', n: shift.length, tenants: new Set(shift.map((r) => r.tenant)).size, first: days(shift)[0], last: days(shift).at(-1), also: 0 },
  ]);
  const link = (p: string) => issues[p];
</script>

<p class="sum"><strong>{merged.length}</strong> reports merged into #{ticket} · <strong>{rows.length}</strong> problems</p>

<table>
  <thead><tr><th>problem</th><th>reports</th><th>tenants</th><th>seen</th><th>ticket</th></tr></thead>
  <tbody>
    {#each rows as r (r.problem)}
      <tr>
        <td><code>{r.problem}</code><br /><span class="what">{WHAT[r.problem]}</span></td>
        <td>{r.n}</td>
        <td>{r.tenants}</td>
        <td>{r.first} → {r.last}</td>
        <td>{#if link(r.problem)}<a href={link(r.problem)}>{link(r.problem).replace(/.*\/issues\//, '#')}</a>{:else}none{/if}</td>
      </tr>
    {/each}
  </tbody>
</table>

{#each rows as r (r.problem)}
  {#if r.also}
    <p class="note">{r.also} of the <code>{r.problem}</code> reports read as a one-day move; counted under <code>{r.problem}</code> by tenant, and again under <code>shift</code>.</p>
  {/if}
{/each}

<style>
  .sum { font-size: 1.1rem; }
  .what, .note { color: var(--muted); font-size: 0.85em; }
</style>
