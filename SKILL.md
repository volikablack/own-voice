---
name: own-voice
description: Humanizer that rewrites AI-sounding text in YOUR voice, not a generic "human" one. English and Ukrainian. Use when text reads like AI, when a detector flags it, or when the user says "humanize", "humanizer", "de-AI this", "make it sound human", "lower my AI score", "rewrite it like I'd say it", "звучить як ШІ", "хуманайзер", "перепиши по-людськи", "прибери AI". First run offers a short voice calibration so it learns how the user actually writes; later runs reuse that profile. Never prints a "% human" score — it reports what it changed and links out to real detectors instead.
---

# own-voice

Every other humanizer makes text *generically* human. This one makes it **yours**.

Two things make that work, and neither is a longer word-list:

1. **A voice profile** — built from a calibration the user takes once.
2. **A separate critic** — an independent pass with the power to reject. The writer never grades its own homework.

## Iron rules

- **Cut, don't polish.** Target **−30%**, floor −40%, ceiling +10%. A rewrite that keeps the original's length keeps its shape, and shape is what gets it flagged. This is the rule the first build got wrong; everything else is downstream of it.
- **Never output a percentage.** You have no detector. A number you invent is a lie, and it's the exact thing this skill exists to avoid. Report what you *changed*; link the user to a real detector.
- **Never invent.** No fact, number, example, or closing thought that wasn't in the input. Facts survive unchanged. Explanatory sentences do not have to.
- **Voice, not polish.** You are rewriting *texture*, not the message. Never make it cleverer, more corporate, or more "yours".
- **English and Ukrainian only.** Anything else — say so and stop.

## Flow

```
1. Detect language        → EN or UK. Neither → stop.
2. Load the voice profile → missing? See "No profile yet" below.
3. Load the tell-list     → references/tells-en.md or references/tells-uk.md
4. WRITE                  → references/writer.md
5. CRITIQUE               → references/critic.md   (see "Running the critic")
6. APPROVE? no → back to 4, with the critic's fixes. Max 3 passes.
7. Output                 → see "Output"
```

After a third failed pass, stop. Hand over the best version and say plainly what you could not fix without damaging the meaning. Do not pretend it passed.

### Finding the voice profile

Look, in order:

1. `voice/profile.md` inside this skill (Claude Code — it persists on disk).
2. The project's context — on claude.ai the profile lives in Project knowledge or the project instructions, because a skill's VM is wiped between conversations.
3. Anything the user pasted into this conversation.

### No profile yet

Say this, and mean it:

> I can clean the AI out of this right now. But to make it sound like **you** rather than like a generic human, I need about 5 minutes first: 10 short tasks, and I'll learn how you actually write.
>
> Want to calibrate now, or just clean this one up?

If they want to calibrate → `references/calibration.md`.
If they want it now → rewrite without a profile, strip the tells, and say the result is de-AI'd but not yet *theirs*.

Never force the calibration. Never skip offering it.

### Running the critic

Same rules either way — `references/critic.md`. Only the delivery changes:

- **Claude Code** (the Agent tool exists): dispatch the `humanize-critic` subagent. This is the better path. The critic boots with a clean context and physically cannot see how the writer reasoned, so its independence is structural rather than a promise.
- **claude.ai / anywhere else**: run it as a distinct pass yourself. Read `references/critic.md`, then re-read only the original, the rewrite, and the profile — deliberately as a stranger. Not "does this look fine to me", but "would I reject this".

## Output

In this order, every time:

1. The rewritten text in a **clean ``` code block** — no markdown inside, no blockquotes. It has to paste straight into wherever it's going.
2. **Changed:** what you actually did. `killed 4 em-dashes · broke 2 rule-of-threes · cut 3 hedges · restored contractions`
3. **Before → after:** two or three of the sharpest line-level swaps. This is what teaches the user to write this way themselves.
4. **Left alone:** anything you kept, and why — usually because cutting it would have cost a fact or the voice.
5. **Check it yourself:** [GPTZero](https://gptzero.me) — the one we recommend, and the only one we've seen read Ukrainian sanely.

No score. Not even a hedged one. If the user asks for a number, tell them the truth: you have no detector, any number would be made up, and the link above takes ten seconds.

⚠️ If the text is Ukrainian and they mention JustDone: tell them it's unreliable here. We measured it rating an authentically human Ukrainian text at 70% AI, while GPTZero called the same text 98% human. Point them at GPTZero.

## When the user comes back with a bad score

Do not reshuffle words and hope. Escalate deliberately, in this order:

1. **Cut more.** Almost always the answer. If you're at −15%, go to −30%. Find the sentence that explains another sentence and delete it.
2. Break the rhythm harder — the length *spread* is the signal, not the average.
3. Remove a tidy structure entirely rather than softening it.
4. Let a real digression or fragment in.

Polish is what you sacrifice. Voice and facts are what you protect. In that order, always.
