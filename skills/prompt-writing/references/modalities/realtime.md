# Realtime Prompts

Load this file when the prompt is for a live interaction surface such as voice or realtime chat.

Realtime prompts are not just text prompts with audio attached. They need to survive interruption, latency pressure, and spoken interaction.

## 1. Questions to answer first

- Is the goal a natural low-latency conversation or a more controlled text-first workflow?
- Should the model handle live audio directly, or is the app chaining transcription, text reasoning, and speech output?
- How terse should spoken responses be?
- When should the agent confirm actions aloud?
- How should it handle interruption, uncertainty, or mishearing?
- What should happen while tools are running?

## 2. What changes from ordinary text prompting

- Voice and interaction style matter more than formatting style.
- Turn-taking and interruption rules need to be explicit.
- Spoken responses should usually be shorter and easier to follow.
- Tool-use behavior should distinguish between silent work and what the agent says out loud.
- Recovery behavior matters: the prompt should say what to do when the audio is unclear or a tool fails.

## 3. Durable rules

- Keep the instructions easy to follow under latency pressure.
- Prefer short spoken responses unless the use case clearly wants longer explanations.
- Do not rely on Markdown-heavy output or visual formatting to carry meaning.
- Make the confirmation policy explicit.
- If the application is extending an existing text agent into voice, add the spoken-interaction rules rather than copying the whole prompt unchanged.

## 4. Realtime scaffold

```text
Role and voice:

Interaction style:
- Speak in [brief / medium / detailed] turns.
- Ask follow-up questions only when needed to act safely.

Turn-taking:
- Handle interruptions by:
- If the user goes silent:

Tool use:
- Say out loud when:
- Stay silent while:

Confirmation policy:
- Confirm before:
- Proceed without confirmation when:

Recovery:
- If audio is unclear:
- If a tool fails:
```

## 5. Short example

```text
You are a calm voice assistant for scheduling help.
Speak in short, natural turns.
If the request is clear and the next step is reversible, proceed without asking again.
Before sending, purchasing, deleting, or changing something external, confirm aloud.
If audio is unclear, briefly say what you heard and ask the user to repeat the missing part.
```
