# own-voice

**A Claude skill that rewrites text in *your* voice** — the one it learned from you — instead of a generic assistant voice. English and Ukrainian. Works in Claude Code and claude.ai.

[Українською нижче ↓](#own-voice-українською)

---

## What it does

You calibrate it once — ten short tasks, about five minutes — and it learns how you actually write. After that, hand it anything: an AI draft that doesn't sound like you, a rushed email, a stiff paragraph. It gives it back in your voice. Your rhythm, your words, your punctuation, the way you open and close.

Not a generic "human" voice. Yours specifically.

## What it is *not* — and the honest story behind that

This started as an AI-humanizer: paste AI text, get back something that beats detectors. We built the whole thing — writer, independent critic, Ukrainian and English pattern-lists — and then we tested it on real detectors with a real voice. Here's what actually happened:

| Text | GPTZero |
|---|---|
| A person, writing by hand | **98% human** |
| Our skill's rewrite of the same idea | **5–47% human** — flagged AI |

We tried it two ways — barely edited, heavily edited, compressed, chopped. It kept scoring AI. And the data pointed somewhere uncomfortable but clear: **a model editing existing text can't reliably read as human. Only a person writing from scratch does.** The one sentence of ours that *did* score human was the one we'd barely touched — long, flowing, with the speech repetition left in. Everything we "improved" — the punchy fragments, the inserted slang — scored worse.

So we stopped selling the thing we couldn't deliver. No detector promises. No "% human". No screenshots of a green gauge.

What survived is the part that actually works, and that nobody else does: **making text sound like a specific person.** That was always the interesting half. Now it's the whole product.

## Why "your voice" and not "human"

Every humanizer makes text *generically* human — smoothed flat until nobody's fingerprints are on it. That's the failure state, not the goal. own-voice does the opposite: it learns one person and writes as them.

The engine is a calibration. It hands you a fixed, deliberately bland baseline and asks you to say the same thing your way. Since the neutral version is known, **every deviation from it is pure voice signal.** Then a separate critic checks the rewrite against your profile and rejects anything that sounds like an assistant instead of you.

## What we learned building it (useful even if you never install it)

- **Chopping text into punchy fragments makes it sound *more* artificial, not less.** That staccato rhythm is what every AI tool produces. Flowing sentences with natural repetition read more human.
- **Compression isn't a trick, it's just voice.** People say less in their own voice than an assistant does — but shrink toward how *they'd* say it, don't shatter it.
- **Word choice betrays the draft.** If the AI wrote «бриф» and you'd say «комунікація», leaving its word in is the tell. Voice means *your* vocabulary, not the model's.
- **AI detectors disagree wildly, and mislead.** On the exact same human-written Ukrainian text: GPTZero said 98% human, JustDone said 70% AI. If a detector flags your own unedited writing, it isn't measuring what it claims. Don't tune your writing to please it.

## Install

Skills don't sync between surfaces, so pick the one you use.

### Claude Code

```bash
git clone https://github.com/volikablack/own-voice ~/.claude/skills/own-voice
```

Say "rewrite this in my voice" and it triggers.

### claude.ai

```bash
git clone https://github.com/volikablack/own-voice
cd own-voice && make zip
```

Then: **Settings → Features → Skills → upload `dist/own-voice.zip`**

Needs Pro, Max, Team or Enterprise with code execution on. Free accounts can't install custom Skills — a platform limit, not ours. Your profile goes in a Project (a skill's VM is wiped between chats); see [voice/README.md](voice/README.md).

## Use

```
rewrite this in my voice: <your text>
```

Or "make it sound like me", or "de-AI this and use my words". First run offers the calibration. Take it — without a profile you get a generic editor, which is the thing we're specifically not.

## What you get back

1. The rewritten text in a clean code block, paste-ready.
2. **In your voice:** what changed to match you, named against your profile.
3. **Before → after:** the sharpest voice swaps, so you start spotting the difference yourself.
4. **Left alone:** facts, and lines that were already yours.
5. **The real test:** you read it. Does it sound like you? Tell it which line doesn't, and it fixes that and learns.

## The calibration

Three groups, stop after any of them:

| Group | What it captures |
|---|---|
| 5 short tasks | Character — blunt or soft, emoji or dry, apologizes or holds. |
| 3 long tasks | Rhythm — how your sentences actually run and where they break. |
| 2 open questions | Your blank page — your subject, your words, no baseline from us. |

Samples of your own writing are welcome on top, but the calibration is the core: samples are usually contaminated (already edited, already AI-touched), while a known baseline makes your every deviation clean signal.

## Honest limits

- **No detector score, ever.** By design, and now you know why.
- **It sounds like you; it doesn't promise to fool anything.** Different claim, and the only one we'll stand behind.
- **English and Ukrainian only.** Else it says so and stops.
- **Facts are held, not improved.** It won't invent the detail your text is missing.
- **The profile is everything.** Skip the calibration and you get a competent generic editor — which is exactly what we didn't want to ship.
- **claude.ai needs a paid plan** with code execution.

## How it fits together

```
your text
    ↓
[WRITER]  ← strip the assistant voice, then apply YOUR voice from the profile
    ↓
[CRITIC]  ← does this sound like the person, or an assistant in their coat?
    ↓        (original + rewrite + profile. never the writer's reasoning.)
APPROVE? ──no──> fixes ──> back to the writer   (max 3 passes)
    ↓ yes
output
```

```
own-voice/
├── SKILL.md                    entry point
├── references/
│   ├── writer.md               rewriting rules
│   ├── critic.md               the six voice checks
│   ├── calibration.md          the ten tasks, EN + UK
│   ├── tells-en.md             generic assistant patterns (English)
│   └── tells-uk.md             generic assistant patterns (Ukrainian)
├── agents/
│   └── humanize-critic.md      Claude Code: the critic as a clean-context subagent
└── voice/
    ├── README.md               where your profile lives
    └── profile.example.md      what one looks like
```

## Licence

MIT. Fork it, or just take the pattern-lists for something of your own.

Built by [Valeriia Chuiko](https://valeria.digital) — AI systems, agents, automation.

---

# own-voice (українською)

**Claude-скіл, що переписує текст *твоїм* голосом** — тим, який вивчив у тебе — замість безликого голосу асистента. Англійською й українською. Працює в Claude Code і claude.ai.

## Що робить

Ти калібруєш його один раз — десять коротких завдань, хвилин п'ять — і він вчить, як ти реально пишеш. Далі кидаєш будь-що: AI-чернетку, що на тебе не схожа, поспіхом написаний лист, дерев'яний абзац. Він повертає це твоїм голосом. Твій ритм, твої слова, твоя пунктуація, як ти заходиш і закінчуєш.

Не абстрактно-людський голос. Саме твій.

## Чим це *не* є — і чесна історія за цим

Починалось як AI-хуманайзер: кидаєш AI-текст, отримуєш те, що б'є детектори. Ми зібрали все — писар, окремий критик, українські й англійські списки патернів — а потім перевірили на живих детекторах живим голосом. Ось що вийшло:

| Текст | GPTZero |
|---|---|
| Людина, руками | **98% людини** |
| Переписування скілом тієї ж думки | **5–47% людини** — позначено AI |

Пробували двома способами — майже не чіпаючи, сильно редагуючи, стискаючи, рубаючи. Все одно AI. І дані вказали в незручний, але ясний бік: **модель, редагуючи готовий текст, не може стабільно читатись як людина. Лише людина, що пише з нуля, може.** Єдине наше речення, яке *таки* дало людину, було те, що ми майже не чіпали — довге, плавне, з живим повтором. Усе «покращене» — рубані обрубки, вставлений сленг — давало гірше.

Тому ми перестали продавати те, чого не тягнемо. Жодних обіцянок детектора. Жодних «% людини». Жодних скрінів зеленої шкали.

Вижила частина, яка справді працює і якої нема ні в кого: **зробити так, щоб текст звучав як конкретна людина.** Це завжди й було цікавою половиною. Тепер це весь продукт.

## Чому «твій голос», а не «людина»

Кожен хуманайзер робить текст *абстрактно*-людським — згладженим до стану, де відбитків уже нема. Це провал, не мета. own-voice навпаки: вчить одну людину й пише як вона.

Двигун — калібрування. Дає фіксовану, навмисне прісну основу й просить сказати те саме своїми словами. Нейтральний варіант відомий, тому **кожне відхилення від нього — чистий сигнал голосу.** Далі окремий критик звіряє переписане з профілем і реджектить усе, що звучить як асистент, а не як ти.

## Що ми зрозуміли, поки будували (корисне, навіть якщо не ставитимеш)

- **Кришити текст на короткі обрубки — робить його AI-шнішим, не навпаки.** Цю рубаність видає кожен AI-інструмент. Плавні речення з живим повтором читаються людяніше.
- **Стиснення — не трюк, а голос.** Людина каже менше своїм голосом, ніж асистент — але стискай до того, як сказала б *вона*, не шматуй.
- **Вибір слова видає чернетку.** Якщо AI написав «бриф», а ти б сказала «комунікація», лишити його слово — це і є tell. Голос це *твій* словник, не моделі.
- **Детектори дико не згодні між собою й вводять в оману.** На тому самому живому українському тексті: GPTZero — 98% людини, JustDone — 70% AI. Якщо детектор позначає твоє нередаговане письмо як AI, він міряє не те. Не підганяй текст під нього.

## Встановлення

Скіли не синхронізуються між поверхнями, тому бери свою.

### Claude Code

```bash
git clone https://github.com/volikablack/own-voice ~/.claude/skills/own-voice
```

Кажеш «перепиши моїм голосом» — спрацьовує.

### claude.ai

```bash
git clone https://github.com/volikablack/own-voice
cd own-voice && make zip
```

Далі: **Settings → Features → Skills → залити `dist/own-voice.zip`**

Треба Pro/Max/Team/Enterprise з code execution. З безкоштовного акаунта кастомні скіли не ставляться — обмеження платформи. Профіль кладеться в Проєкт (VM скіла стирається між чатами); див. [voice/README.md](voice/README.md).

## Як користуватись

```
перепиши моїм голосом: <твій текст>
```

Або «зроби як я», або «прибери AI і використай мої слова». Перший запуск запропонує калібрування. Пройди — без профілю це просто загальний редактор, тобто рівно те, чим ми не є.

## Що приходить назад

1. Переписаний текст чистим код-блоком, готовий вставляти.
2. **Твоїм голосом:** що змінилось під тебе, названо проти твого профілю.
3. **До → після:** найгостріші заміни голосу, щоб ти сама почала бачити різницю.
4. **Не чіпав:** факти й рядки, що вже були твої.
5. **Справжній тест:** ти читаєш. Схоже на тебе? Кажеш, який рядок ні — і воно виправляє й запам'ятовує.

## Калібрування

Три групи, зупинитись можна після будь-якої:

| Група | Що ловить |
|---|---|
| 5 коротких | Характер — різко чи м'яко, з емодзі чи сухо, вибачається чи тримає. |
| 3 довгих | Ритм — як твої речення реально течуть і де ламаються. |
| 2 питання | Твій чистий аркуш — своя тема, свої слова, без нашої основи. |

Свої тексти можна докинути зверху, але калібрування головне: зразки зазвичай забруднені (вже редаговані, вже AI-торкані), а відома основа робить кожне твоє відхилення чистим сигналом.

## Чесні обмеження

- **Ніякої оцінки детектора.** Свідомо, і тепер ти знаєш чому.
- **Звучить як ти; не обіцяє нікого обдурити.** Інша обіцянка, і єдина, за яку ми ручаємось.
- **Тільки англійська й українська.** Інше — скаже й зупиниться.
- **Факти тримає, не покращує.** Не вигадає деталь, якої тексту бракує.
- **Профіль — це все.** Пропустиш калібрування — отримаєш загальний редактор, тобто рівно те, чого ми не хотіли.
- **claude.ai потребує платного тарифу** з code execution.

## Ліцензія

MIT. Форкай, або просто візьми списки патернів під щось своє.

Зроблено [Валерією Чуйко](https://valeria.digital) — AI-системи, агенти, автоматизація.
