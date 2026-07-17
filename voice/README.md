# Your voice profile lives here

`profile.md` in this folder is the whole point of own-voice. Without it you get a generic edit. With it you get *your* text.

You don't write it by hand. Run the skill, take the calibration, it writes it for you and shows it to you first.

## Claude Code

It just works. The profile sits at `voice/profile.md` and persists — write it once, every future run reads it.

It's **gitignored on purpose.** Your profile is a fingerprint of how you write. Don't commit it, don't paste it in an issue.

## claude.ai

A skill's VM is wiped between conversations, so a file written here dies with the chat. Projects are the answer — they're built for exactly this split: **a Project carries who you are, a skill carries what to do.**

1. Take the calibration once.
2. Copy the profile it hands you.
3. Put it in a Project — either as a knowledge file or in the project instructions.
4. Work inside that Project. The skill reads the profile from context.

## Keep it alive

A profile isn't finished. Every time you correct a rewrite — "no, I'd never say it like that" — that correction is signal. Fold it back in.

The people who get the most out of this are the ones whose profile is six months old and has been edited thirty times.

## Something to keep in mind

This describes how you write, closely enough to imitate you. Treat it like any other thing that's yours: keep it out of public repos, don't hand it to services you haven't read the terms of.
