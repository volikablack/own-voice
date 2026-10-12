# Where your voice profile lives

Your profile is the whole point of own-voice. Without it you get a generic edit. With it you get *your* text.

You don't write it by hand. Run the skill, take the calibration, it writes the profile for you and shows it to you first.

The profile is your data, not part of the skill, so it never goes into the skill's folder. This `voice/` folder only holds this note and `profile.example.md`, a fictional example to read.

## Claude Code (or any agent with a local disk)

The profile is saved to `~/.own-voice/profile.md`. Write it once, every future run reads it, and updating or reinstalling the skill never touches it.

Want it somewhere else? Tell the skill the folder, or add a line like `own-voice data folder: ~/Documents/voice` to your CLAUDE.md so every session finds it.

**Upgrading from an older local install:** if your profile sits at `voice/profile.md` inside the skill folder, the skill offers to move it to `~/.own-voice/profile.md` on the next run. Nothing moves without your yes.

## claude.ai

A chat's sandbox is wiped between conversations, so a file written there dies with the chat. Projects are the answer – they're built for exactly this split: **a Project carries who you are, a skill carries what to do.**

1. Take the calibration once.
2. Copy the profile it hands you.
3. Put it in a Project – either as a knowledge file or in the project instructions.
4. Work inside that Project. The skill reads the profile from context.

You can also just paste your profile into a chat.

## Keep it alive

A profile isn't finished. Every time you correct a rewrite – "no, I'd never say it like that" – that correction is signal. Fold it back in.

The people who get the most out of this are the ones whose profile is six months old and has been edited thirty times.

## Something to keep in mind

This describes how you write, closely enough to imitate you. Treat it like any other thing that's yours: keep it out of public repos, don't hand it to services you haven't read the terms of.
