---
name: own-voice
description: Rewrites text in YOUR voice — the one it learned from you — instead of a generic "assistant" voice. Use when an AI draft doesn't sound like you, when you wrote something fast and want it in your own voice rather than a polished corporate one, or when the user says "in my voice", "make it sound like me", "rewrite this the way I'd say it", "de-AI this", "звучить як ШІ", "перепиши моїм голосом", "зроби як я". First run offers a short voice calibration so it learns how you actually write; later runs reuse that profile. Honest scope: this is a voice tool, not an AI-detector beater — it never prints a "% human" score and never promises to fool a detector, because a model editing text can't do that reliably (we tested it). What it does reliably is make text sound like the specific person it learned.
---

# own-voice

Rewrites text so it sounds like **you** — the specific person the skill has learned — not like an assistant, and not like a generic "human".

## What this is, and what it isn't

**It is** a voice tool. You calibrate it once; after that it rewrites any text — an AI draft, a rushed note, a stiff email — into the way *you* actually write.

**It is not** an AI-detector beater. It never prints a "% human" and never promises to slip past GPTShield or JustDone or anything else. We built that first, tested it on real detectors, and the honest result is: a model editing existing text can't reliably score as human — only a person writing from scratch does. So we stopped selling that and kept the part that works: sounding like you.

If your text stops sounding like an assistant and starts sounding like you, that's the win. Whether some detector agrees is not our claim to make.

## Iron rules

- **Their voice, not a better voice.** The profile is the target. If they write plain, you write plain. Never upgrade them into someone wittier or more corporate. The number one failure here is quietly making everything sound like a good copywriter.
- **Never invent.** No fact, number, name, example, or closing thought that wasn't in the input. Facts survive unchanged.
- **Don't perform.** Writing that *tries* to look human — a fragment every other line, forced slang, staccato chopping — reads worse than the draft did. We measured it. A lightly-edited natural sentence beat a heavily "improved" punchy one every time. Restraint wins.
- **Cut toward how much they'd actually say.** People are more economical in their own voice than an assistant is. Trim what they wouldn't bother saying — but as voice-matching, not as a trick, and never past the point where it reads naturally.
- **English and Ukrainian only.** Anything else — say so and stop.

## Flow

```
1. Detect language        → EN or UK. Neither → stop.
2. Load the voice profile → missing? See "No profile yet".
3. Load the reference     → references/tells-en.md or references/tells-uk.md
                            (generic assistant patterns to strip first)
4. WRITE                  → references/writer.md
5. CRITIQUE               → references/critic.md   (see "Running the critic")
6. APPROVE? no → back to 4, with the critic's fixes. Max 3 passes.
7. Output                 → see "Output"
```

After a third failed pass, stop. Hand over the best version and say plainly what you couldn't make sound like them without damaging the meaning. Don't pretend it landed.

### Where the voice profile lives

The profile is the user's data, not part of the skill. **Never write it, or anything else, into the skill's own folder** – the skill may arrive as text with no folder at all, and a skill folder gets replaced on update.

Look for it in this order:

1. **The user's data folder.** Default `~/.own-voice/profile.md`. If the user named another folder (in this chat, or with a line like `own-voice data folder: <path>` in their CLAUDE.md or project instructions), use `<that folder>/profile.md` instead.
2. **Project knowledge** (claude.ai): a file or instructions block holding their profile.
3. **Pasted into this conversation.**

Saving a new or corrected profile: show it first, save on a yes.

- **A persistent local disk** (Claude Code and similar): write `~/.own-voice/profile.md` (or their chosen folder), creating the folder if needed. Tell them the path in one line.
- **No persistent disk** (claude.ai, a chat sandbox): hand the profile over in a code block and tell them to add it to a Project as knowledge or to the project instructions. A file written in a chat sandbox disappears with the chat.

**Old local installs.** If the skill is installed as a folder on this machine (for example `~/.claude/skills/own-voice/`) and there is a `voice/profile.md` inside it, that's a profile from an older version. Offer once: "Your profile is inside the skill folder, where a reinstall or update can wipe it. Move it to `~/.own-voice/profile.md`?" On a yes, copy it there, check the copy reads back the same, then delete the old file. Until they answer, read it from where it is.

### No profile yet

The profile is the whole point — without it you're just a generic editor. Say:

> I can clean this up right now. But to make it sound like **you** and not a generic voice, I need about 5 minutes first: 10 short tasks, and I'll learn how you actually write.
>
> Calibrate now, or just do a plain pass on this one?

Calibrate → `references/calibration.md`. Plain pass → strip the generic patterns, but tell them it's de-assistant'd, not yet *theirs*.

### Running the critic

Same rules either way — `references/critic.md`. Only delivery changes:

- **Subagents available** (Claude Code: an Agent/Task tool exists): spawn a general-purpose subagent and put everything it needs **inline in its prompt**: the full text of `references/critic.md` as you received it, then the original, the rewrite, the profile and the language. Never point it at a file path for the critic rules, and never pass your own reasoning. It boots clean and can't see the writer's thinking – the independence is structural, not a promise.
- **No subagents** (claude.ai / elsewhere): run it as a distinct pass. Re-read `references/critic.md`, then only the original, the rewrite, and the profile – as a stranger asking "does this sound like the person in the profile, or like an assistant wearing their coat?"

`agents/humanize-critic.md` is an optional extra for people who installed the skill locally from GitHub and copied it into their agents folder themselves. The skill never needs it and never installs it.

## Output

1. The rewritten text in a **clean ``` code block** — no markdown inside, paste-ready.
2. **In your voice:** what you changed to match them, named against profile markers. `swapped "дедлайн"→"строк" · kept your commas, dropped the em-dashes · folded the punchy ending back in the way you do`
3. **Before → after:** two or three of the sharpest voice swaps. This is what teaches them to spot the difference themselves.
4. **Left alone:** facts, and any line that was already theirs.
5. **The real test:** read it. Does it sound like you? If one line doesn't, tell me which — I'll fix it and learn the correction.

No score. If they ask about detectors, tell them the truth: this is a voice tool, not a detector beater; if they want to check AI-detection anyway, GPTZero reads Ukrainian more sanely than JustDone — but the only test we stand behind is whether it sounds like them.

## When a line doesn't sound like them

Don't reshuffle and hope. Ask which line, and fix the specific thing:

- Wrong word for them → swap to theirs (and note it for the profile).
- Too polished → strip a layer, let it be plainer.
- Too performed → un-chop it, let it flow the way they actually write.

Every correction they give is profile signal. Fold it back in — that's how the voice sharpens over time. Updating the saved profile follows the same rule as saving it: show the change, save on a yes, and only to the user's data folder or their Project (see "Where the voice profile lives").
