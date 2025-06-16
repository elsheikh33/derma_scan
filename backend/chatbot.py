# from langchain_community.vectorstores import FAISS
# from langchain_huggingface import HuggingFaceEmbeddings
# # Load FAISS Index
# def faiss_index_loader(db_path):
#     embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
#     db = FAISS.load_local(db_path, embeddings, allow_dangerous_deserialization=True)
#     return db
#
# db=faiss_index_loader("backend/dbDerma")
#
# import requests
#
#
# def chatgpt_respond_generator(query, context):
#     api_key = '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'
#     url = 'https://api.openai.com/v1/chat/completions'
#
#     headers = {
#         'Content-Type': 'application/json',
#         'Authorization': f'Bearer {api_key}',
#     }
#
#     prompt = f"Context: {context}\n\nQuestion: {query}\n\nAnswer:"
#
#     data = {
#         'model': 'gpt-4-turbo',
#         'messages': [
#             {'role': 'user', 'content': prompt}
#         ],
#         'max_tokens': 2000,
#     }
#
#     try:
#         response = requests.post(url, headers=headers, json=data)
#         if response.status_code == 200:
#             result = response.json()
#             answer = result['choices'][0]['message']['content']
#             return answer.replace('**', '')  # Clean markdown
#         else:
#             return f"❌ API Error: {response.status_code} - {response.text}"
#     except Exception as e:
#         return f"❌ Exception occurred: {e}"
#
# if __name__ == "__main__":
#     # In a real RAG system, you'd retrieve `context` from a vector DB using the query.
#     context = "Skin diseases like eczema, vitiligo, acne, and melanoma have different causes and treatments."
#     query = "What are the symptoms of vitiligo and how is it treated?"
#
#     answer = chatgpt_respond_generator(query, context)
#     print("💬 ChatGPT Response:\n", answer)
