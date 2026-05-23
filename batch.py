import anthropic

from anthropic.types.message_create_params import MessageCreateParamsNonStreaming
from anthropic.types.messages.batch_create_params import Request

client = anthropic.Anthropic()

message_batch = client.messages.batches.create(
	requests=[Request(
		custom_id="msg-1",
		params=MessageCreateParamsNonStreaming(
			model="claude-opus-4-7",
			max_tokens=1024,
			messages=[
				{
					"role": "user",
					"content": "Hello, world",
				}
			],
		),
	)]
)

print(message_batch)

f = open("batches.txt", "a")
f.write(message_batch.id + "\n")
f.close()
