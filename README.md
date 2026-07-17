# own-voice

**An AI humanizer that writes in *your* voice instead of a generic one.** English and Ukrainian. Runs as a Skill in Claude Code and claude.ai.

[Українською нижче ↓](#own-voice-українською)

---

## The problem with humanizers

Paste AI text into any humanizer and you get back text that isn't a robot. It also isn't you. It's an average person, smoothed flat until nobody's fingerprints are on it. Detector score improves, and your writing quietly stops being yours.

Most of them do one of two things. Either they invent a "94% human" number they have no way of knowing, or they run your text through a detector and shuffle words until the bar turns green. The first is a lie. The second optimizes for a detector instead of for a reader.

own-voice does neither.

## What's different

**It learns how you actually write.** Once, up front, you take a short calibration: ten tasks, about five minutes. It writes a voice profile from your answers. Every rewrite after that targets *you*, not "human".

**The writer doesn't grade itself.** A separate critic reviews every rewrite with the power to reject it. Seven checks, and it sends the text back until it passes. In Claude Code the critic runs as a subagent with a clean context, so it physically can't see how the writer reasoned. That independence is the point.

**No made-up scores.** It has no detector, so it never prints a percentage. It tells you what it changed, shows you the sharpest before/after swaps, and links you to a real detector to check yourself. Ten seconds, and the number is true.

**It also knows Ukrainian.** Nearly every humanizer is English-only. This one ships a full Ukrainian tell-list: the calques, the officialese, the "не просто X, а Y", the rule-of-three that Ukrainian AI text falls into.

## Why the calibration and not "paste me some samples"

Samples are contaminated. What people hand over has usually been through a model or an editor, so you learn the editor.

The calibration hands you a fixed, deliberately smooth baseline and asks you to say the same thing your way. Since the neutral version is known, **every deviation from it is pure voice signal.** Nothing in the answer is noise.

Three groups, and you can stop after any of them:

| Group | What it measures |
|---|---|
| 5 short tasks | Character. Blunt or soft, emoji or dry, apologizes or holds the line. |
| 3 long tasks | **Rhythm.** The main event. Uniform rhythm is the #1 AI signal, and it's invisible in a single sentence. |
| 2 open questions | Your blank page. Your own subject, your own words, no baseline from us. |

## The one thing we got wrong, and what it taught us

If you take a single idea from this repo, take this one. It cost us a rebuild.

The first version had a rule: preserve length within ±15%. Sensible-sounding. Padding is an AI tell, so don't pad.

Then we tested it. Same detector, same language, same source text:

| | Length vs original | GPTZero |
|---|---|---|
| A person, rewriting by hand | **−34%** | **98% human** |
| Our v1, rules obeyed perfectly | −8% | 47% human — *classified AI generated* |

The v1 output had a clean vocabulary. Every tell on the list, gone. It still got flagged, because **we swapped the words and kept the skeleton, and the skeleton is the signal.**

Look at one idea, both versions:

> **Person:** «ти робиш, а в замовника своє "красиво"» — 6 words
> **Our v1:** «ти робиш красиво, а виявляється, шо красиво для неї означало щось геть інше» — 12 words

Same meaning. Twice the words. The long one got highlighted as an AI sentence; the short one didn't.

A model explains to the end, because it's afraid of being misunderstood. A person says half and trusts you for the rest. **That trust is what reads as human** — only someone who knows their reader takes that risk.

So the rule inverted. Target −30%. Floor −40%. Cutting isn't damage, it's the whole move, and everything else in this repo is downstream of it.

Rhythm still matters — the **spread** of sentence lengths, not the average — but compressing fixes rhythm for free.

## Detectors: what we actually measured

Same Ukrainian text, written by a human, by hand:

| Detector | Verdict |
|---|---|
| GPTZero | 98% human ✅ |
| JustDone | **70% AI** ❌ |

JustDone rates authentic human Ukrainian as mostly AI. Its breakdown even reports in plagiarism terms ("23% Identical", "17% Paraphrased AI"), which suggests it's answering a different question than the one you're asking.

**So: use [GPTZero](https://gptzero.me).** For Ukrainian especially. If a detector flags your own unedited writing as AI, it isn't measuring what it claims to, and tuning your prose to please it makes your writing worse, not more human.

## Over-correction

The failure nobody talks about. Push a humanizer hard enough and it starts *performing* humanity: a fragment every other line, manufactured asides, deliberate typos. Tell-list clean, unreadable text. Worse than the AI draft.

The critic here cuts both ways. One check hunts AI smell; another one rejects text that's trying too hard. The target is a person writing normally, not a person doing an impression of a person.

## Install

Skills don't sync between surfaces, so pick the one you use. Both, if you use both.

### Claude Code

```bash
git clone https://github.com/volikablack/own-voice ~/.claude/skills/own-voice
```

That's it. Say "humanize this" and it triggers.

### claude.ai

```bash
git clone https://github.com/volikablack/own-voice
cd own-voice && make zip
```

Then: **Settings → Features → Skills → upload `dist/own-voice.zip`**

Needs Pro, Max, Team or Enterprise with code execution turned on. Free accounts can't install custom Skills at all. That's a platform limit, not ours.

Your profile goes in a Project, since a skill's VM is wiped between chats. See [voice/README.md](voice/README.md).

## Use

```
humanize this: <your text>
```

Or `de-AI this`, or `rewrite it like I'd say it`, or just paste and say it sounds like AI.

First run offers the calibration. Take it. That's the whole product. Skip it and you get a competent de-AI'er, which is what everything else already does.

## What you get back

1. The rewritten text in a clean code block, ready to paste.
2. **Changed:** `killed 4 em-dashes · broke 2 rule-of-threes · cut 3 hedges · restored contractions`
3. **Before → after:** the sharpest line-level swaps, so you start writing this way yourself.
4. **Left alone:** what it kept, and why.
5. A link to [GPTZero](https://gptzero.me) to check for real.

## Honest limits

- **No score, ever.** By design. If you want a number, the link is right there.
- **v1 failed the first real test.** The numbers in the table above are our own. We shipped the fix, not the excuse — but if you find it still keeping too much shape, that's a bug and we want to hear it.
- **English and Ukrainian only.** Anything else, it says so and stops.
- **It won't save a text with nothing in it.** Humanizing an empty argument gives you a well-written empty argument.
- **Facts are held, not improved.** It won't invent the specific detail your copy is missing. That's on you.
- **claude.ai needs a paid plan** with code execution. Not our call.
- **Detectors move.** Anything that claims a guaranteed score is selling you something.

## How it fits together

```
your text
    ↓
[WRITER]  ← voice profile + tell-list for the language
    ↓
[CRITIC]  ← original + rewrite + profile. Never the writer's reasoning.
    ↓
APPROVE? ──no──> fixes ──> back to the writer   (max 3 passes)
    ↓ yes
output
```

Three failed passes and it stops, hands you the best version, and says plainly what it couldn't fix without damaging your meaning. It doesn't pretend.

```
own-voice/
├── SKILL.md                    entry point
├── references/
│   ├── writer.md               rewriting rules
│   ├── critic.md               the seven checks
│   ├── calibration.md          the ten tasks, EN + UK
│   ├── tells-en.md             English kill-list
│   └── tells-uk.md             Ukrainian kill-list
├── agents/
│   └── humanize-critic.md      Claude Code: the critic as a clean-context subagent
└── voice/
    ├── README.md               where your profile lives
    └── profile.example.md      what one looks like
```

## Licence

MIT. Fork it, or just rip the tell-lists out for something of your own.

Built by [Valeriia Chuiko](https://valeria.digital) — AI systems, agents, automation.

---

# own-voice (українською)

**Хуманайзер, який пише *твоїм* голосом, а не абстрактно-людським.** Англійською й українською. Працює як Skill у Claude Code і claude.ai.

## Проблема всіх хуманайзерів

Кидаєш AI-текст у будь-який хуманайзер, і назад приходить текст, який уже не робот. Але й не ти. Це усереднена людина, згладжена до стану, де ніяких відбитків уже не лишилось. Оцінка детектора покращилась, а твоє письмо тихо перестало бути твоїм.

Більшість із них роблять одне з двох. Або малюють «94% людини», яких не мають звідки знати. Або ганяють текст через детектор і перебирають слова, поки шкала не позеленіє. Перше — брехня. Друге оптимізує під детектор, а не під читача.

Тут ні того, ні того.

## Чим відрізняється

**Вчить, як ти реально пишеш.** Один раз на старті проходиш калібрування: десять завдань, хвилин пʼять. З твоїх відповідей складається профіль голосу. Далі кожне переписування цілиться в **тебе**, а не в «людину».

**Писар не оцінює сам себе.** Кожен текст читає окремий критик, який має право відхилити — сім перевірок, і він жене назад, поки не пройде. У Claude Code критик іде сабагентом з чистим контекстом, тобто фізично не бачить, як міркував писар. У цьому весь сенс.

**Жодних вигаданих цифр.** Детектора в нього нема, тому він ніколи не пише відсоток. Каже, що змінив, показує найгостріші заміни до/після, і дає посилання на живий детектор — перевір сам. Десять секунд, і число справжнє.

**І він знає українську.** Майже всі хуманайзери тільки англійські. Тут повний український список tells: кальки, канцелярит, «не просто X, а Y», і те саме «по-перше/по-друге/по-третє», в яке скочується українська AI-мова.

## Чому калібрування, а не «кинь свої тексти»

Зразки забруднені. Те, що людина кидає, зазвичай уже пройшло через модель або редактора. Вивчиш редактора.

Калібрування дає фіксовану, навмисне гладку основу й просить сказати те саме своїми словами. Нейтральний варіант відомий, тому **кожне відхилення від нього — чистий сигнал голосу.** У відповіді нема шуму.

Три групи, зупинитись можна після будь-якої:

| Група | Що міряє |
|---|---|
| 5 коротких | Характер. Різко чи мʼяко, з емодзі чи сухо, вибачається чи тримає позицію. |
| 3 довгих | **Ритм.** Головне: рівний ритм — сигнал AI номер один, і в одному реченні його не видно. |
| 2 питання | Твій чистий аркуш. Своя тема, свої слова, без нашої основи. |

## Що ми зробили не так, і чого це навчило

Якщо забирати з цього репо одну думку — оцю. Вона коштувала нам переробки.

У першій версії стояло правило: тримати довжину ±15%. Звучить розумно. Набивання це AI-tell, тому не набивай.

Потім ми перевірили. Той самий детектор, та сама мова, той самий вихідний текст:

| | Довжина проти оригіналу | GPTZero |
|---|---|---|
| Людина, переписала руками | **−34%** | **98% людини** |
| Наша v1, правила виконані бездоганно | −8% | 47% людини — *класифіковано як AI* |

У v1 був чистий словник. Жодного tell зі списку не лишилось. І все одно завал, бо **ми поміняли слова й лишили скелет, а скелет і є сигнал.**

Одна думка, дві версії:

> **Людина:** «ти робиш, а в замовника своє "красиво"» — 6 слів
> **Наша v1:** «ти робиш красиво, а виявляється, шо красиво для неї означало щось геть інше» — 12 слів

Той самий сенс. Удвічі більше слів. Довгу детектор підсвітив як AI-речення, коротку ні.

Модель договорює до кінця, бо боїться бути незрозумілою. Людина каже половину й довіряє читачу добрати решту. **Оця довіра й читається як людське** — на такий ризик іде тільки той, хто знає свого читача.

Тому правило перевернулось. Ціль −30%. Дно −40%. Різати це не втрата, це головний хід, і все інше в цьому репо стоїть на ньому.

Ритм лишається важливим — саме **розкид** довжин, не середнє — але стиснення лагодить ритм задарма.

## Детектори: що ми реально поміряли

Один український текст, писала людина руками:

| Детектор | Вирок |
|---|---|
| GPTZero | 98% людини ✅ |
| JustDone | **70% AI** ❌ |

JustDone вважає живий український текст переважно машинним. Він навіть звітує в термінах антиплагіату («23% Identical», «17% Paraphrased AI») — схоже, відповідає взагалі на інше питання.

**Тому: [GPTZero](https://gptzero.me).** Для української особливо. Якщо детектор називає AI твоє власне нередаговане письмо, він міряє не те, що обіцяє. Підганяти під нього текст означає псувати його, а не олюднювати.

## Перегин

Провал, про який ніхто не говорить. Натисни на хуманайзер сильніше — і він починає **зображати** людину: обрубок через рядок, штучні відступи, навмисні одруківки. Список tells чистий, читати неможливо. Гірше, ніж було.

Критик тут ріже в обидва боки. Одна перевірка полює на AI-запах, інша валить текст, який занадто старається. Ціль — людина, яка нормально пише. Не людина, яка зображає людину.

## Встановлення

Скіли не синхронізуються між поверхнями, тому бери свою. Або обидві.

### Claude Code

```bash
git clone https://github.com/volikablack/own-voice ~/.claude/skills/own-voice
```

Усе. Кажеш «перепиши по-людськи» — спрацьовує.

### claude.ai

```bash
git clone https://github.com/volikablack/own-voice
cd own-voice && make zip
```

Далі: **Settings → Features → Skills → залити `dist/own-voice.zip`**

Треба Pro, Max, Team або Enterprise з увімкненим code execution. З безкоштовного акаунта кастомні скіли не ставляться — це обмеження платформи, не наше.

Профіль кладеться в Проєкт, бо VM скіла стирається між чатами. Деталі — [voice/README.md](voice/README.md).

## Як користуватись

```
перепиши по-людськи: <твій текст>
```

Або «прибери AI», або «хуманайзер», або просто кинь текст і скажи, що він пахне ШІ.

Перший запуск запропонує калібрування. Пройди — це і є продукт. Пропустиш — отримаєш нормальний де-AI, тобто те, що вміють усі.

## Що приходить назад

1. Переписаний текст чистим код-блоком, готовий вставляти.
2. **Зроблено:** `прибрав 4 тире · розламав два rule-of-three · зрізав 3 хеджі`
3. **До → після:** найгостріші заміни, щоб ти сама почала так писати.
4. **Не чіпав:** що лишив і чому.
5. Посилання на [GPTZero](https://gptzero.me), перевірити по-справжньому.

## Чесні обмеження

- **Ніяких оцінок.** Свідомо. Треба цифра — посилання вище.
- **v1 завалила перший же живий тест.** Цифри в таблиці вище наші власні. Ми виклали виправлення, а не виправдання — але якщо побачиш, що воно й далі тримає забагато форми, це баг, і ми хочемо про нього знати.
- **Тільки англійська й українська.** Інше — скаже й зупиниться.
- **Порожній текст не врятує.** Обробиш порожню думку — отримаєш гарно написану порожню думку.
- **Факти тримає, а не покращує.** Він не вигадає ту конкретну деталь, якої твоєму тексту бракує. Це на тобі.
- **claude.ai потребує платного тарифу** з code execution. Не наше рішення.
- **Детектори змінюються.** Хто обіцяє гарантований відсоток — той тобі щось продає.

## Ліцензія

MIT. Форкай, або просто витягни списки tells під щось своє.

Зроблено [Валерією Чуйко](https://valeria.digital) — AI-системи, агенти, автоматизація.
