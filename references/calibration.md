# Calibration

Ten tasks. Roughly five minutes. It produces `voice/profile.md`.

## Why this, and not "paste me some of your writing"

Samples people hand over are contaminated. They've been through a model, an editor, or both — and you'd be learning the editor.

Here you hand them a fixed, deliberately smooth baseline and ask them to say the same thing their way. **You know exactly what the neutral version sounds like, so every deviation from it is pure voice signal.** Nothing else in the answer is noise.

Samples are still welcome as a bonus. The test catches *how they rewrite*; samples catch *how they start from a blank page*; the two free-write tasks below cover most of that gap anyway.

## Delivery — three batches, not ten questions

Ten prompts in one wall makes people bail. One at a time makes it a interrogation. Send them in three groups, and say up front they can stop after any of them:

- **After group 1** (5 short) → a rough profile. Register and vocabulary, no rhythm.
- **After group 2** (+3 long) → the real thing. Rhythm is the main event and it only lives here.
- **After group 3** (+2 questions) → best. Their blank-page voice and their own subject matter.

Tell them that. A profile that exists after five minutes beats a perfect one they walked away from.

---

## Group 1 — five short. Character.

No rhythm here, and none needed. This is reaction: sharp or soft, emoji or dry, apologizes or holds.

### UK

```
1. НЕ ПОГОДИТИСЬ
Розумію вашу точку зору, проте маю дещо інше бачення цього питання.

2. ВИЗНАТИ ФАКАП
На жаль, з мого боку сталася помилка. Беру на себе відповідальність
і виправлю найближчим часом.

3. ПІДНЯТИ ЦІНУ
У звʼязку зі зростанням обсягу роботи хотіла б обговорити перегляд
вартості.

4. ВІДМОВИТИ
Дякую за пропозицію, але, на жаль, змушена відмовитися.

5. ДОБРА НОВИНА
Це чудова новина! Дуже рада за вас.
```

### EN

```
1. DISAGREE
I understand your point of view, however I have a somewhat different
perspective on this matter.

2. OWN A MISTAKE
Unfortunately, an error occurred on my end. I take responsibility and
will fix it shortly.

3. RAISE YOUR RATE
Given the increased scope of work, I'd like to discuss revisiting the rate.

4. SAY NO
Thank you for the offer, but unfortunately I have to decline.

5. GOOD NEWS
That's wonderful news! I'm so happy for you.
```

---

## Group 2 — three long. Rhythm.

**The important group.** Uniform rhythm is the number one AI signal, and it is *physically invisible in a single sentence*. Only a paragraph shows the spread.

Each baseline is loaded on purpose — rule-of-three, even cadence, a tidy moral at the end. Watch which ones they break and how. That's the profile.

### UK

```
6. ЗАТРИМКА
Хочу повідомити, що робота займе трохи більше часу, ніж планувалося
спочатку. У процесі виникли додаткові обставини, які потребували
детального опрацювання, і я вирішила приділити цьому належну увагу,
щоб результат був якісним. Прошу вибачення за незручності. Нові терміни
повідомлю найближчим часом і надалі триматиму вас у курсі.

7. ПОЯСНИТИ СКЛАДНЕ
Відкладання важливих справ на останній момент призводить до низки
негативних наслідків. По-перше, зростає рівень стресу. По-друге,
знижується якість результату, адже часу на перевірку не залишається.
По-третє, страждають стосунки з людьми, які на вас розраховують.
Тому важливо планувати заздалегідь і розподіляти навантаження рівномірно.

8. НАПОЛЯГТИ
Я все ж таки вважаю, що варто зробити саме так. Розумію, що моя позиція
може здаватися незручною, і ціную те, що ви поділилися своїми
міркуваннями. Проте досвід підказує мені, що альтернативний варіант
призведе до додаткових складнощів у майбутньому. Пропоную зупинитися
на моєму варіанті, а якщо він себе не виправдає — я візьму
відповідальність на себе.
```

### EN

```
6. THE DELAY
I wanted to let you know that the work will take a little longer than
originally planned. Some additional considerations came up during the
process that required careful attention, and I decided to give them the
time they deserved so that the result meets the standard we agreed on.
I apologize for any inconvenience. I'll share updated timelines shortly
and will keep you posted throughout.

7. EXPLAIN SOMETHING
Putting off important tasks until the last minute leads to a number of
negative consequences. First, stress levels rise. Second, the quality of
the result suffers, since there's no time left to review it. Third,
relationships with people counting on you take a hit. That's why it's
important to plan ahead and distribute the workload evenly.

8. HOLD YOUR GROUND
I still believe we should do it this way. I understand my position may
seem inconvenient, and I appreciate you sharing your thinking. However,
experience tells me the alternative will create additional complications
down the line. I propose we go with my approach, and if it doesn't work
out, I'll take responsibility.
```

---

## Group 3 — two questions. Blank page.

No baseline. They write cold, about their own life.

### UK

```
9.  Розкажи своїми словами, чим ти займаєшся. Так, як сказала б новому
    знайомому на вечірці.

10. Згадай свій останній робочий факап і розкажи, що сталося.
```

### EN

```
9.  Tell me what you do, in your own words. The way you'd say it to
    someone you just met at a party.

10. Think of the last time you screwed something up at work. Tell me
    what happened.
```

---

## Rules for editing this file

Break these and the test stops measuring voice.

- **Only universally-lived situations.** Being late, saying no, asking for money, messing up. **Never a profession.** Hand someone a baseline about a job they've never done and they'll produce a stiff translation — and you will record their stiffness as their voice. That's how you poison a profile.
- **Domain arrives on its own**, through group 3. Guessing the user's field is unnecessary and harmful.
- **Baselines stay deliberately smooth.** They're the zero point. If a baseline already sounds human, that task measures nothing.
- **Thanks is out.** Everyone sounds the same saying thank you. Zero signal.
- **EN is a mirror, not a translation.** Same register, native phrasing.

## Extraction → `voice/profile.md`

### From group 2 (rhythm — do this first, it's the backbone)

- **Median sentence length, and the spread.** Shortest and longest. The spread is the number that matters — write it down literally.
- How they join clauses: «і» / commas / dashes / full stops. Which do they reach for and which do they never use?
- Did they keep the rule-of-three or break it? Into what?
- Did the tidy closing moral survive? People who cut it have a strong voice.
- Paragraph shape — even blocks, or one line then a wall?

### From group 1 (character)

- Register per situation: do they apologize, hedge, or go straight in?
- Emoji — which, how many, where.
- Warm or dry. Reflexive "sorry"/«дякую», or not.
- What do they cut first when they rewrite? That's usually their strongest instinct.

### From group 3 (blank page)

- The opening move. Most people have one or two habits.
- Their own vocabulary — trade words, slang, what they keep in English.
- Do they own a screwup with self-deprecation, or get defensive? That one line predicts a lot of their writing.

### Across everything

- Punctuation fingerprint: dash vs comma, quote style (straight or typographic), ellipses, exclamation marks.
- Contractions (EN) / surzhyk lexicon with Ukrainian grammar (UK).
- Filler and connective words they actually use.
- **What they never do.** Write this down explicitly. The never-list carries as much weight as the do-list, and the writer will violate it if you don't.

Write the profile in the user's own language. Show it to them before saving — they'll correct it, and the correction itself is more signal.
