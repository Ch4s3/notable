alias Notable.Repo
alias Notable.Accounts.User
alias Notable.Documents.{Doc, Annotation}

for _ <- 1..10 do
  Repo.insert!(%User{
    name: Faker.Name.name,
    email: Faker.Internet.safe_email
  })
end


for _ <- 1..15 do
  body = Faker.Lorem.paragraphs(%Range{first: 1, last: 20}) |> Enum.join("\n\n")
  length = String.length(body)
  doc =
    Repo.insert!(%Doc{
      title: Faker.Lorem.sentence,
      body: body,
      accounts_users_id: Enum.random(1..10)
    })

  chunks = div(length, 200)
  Enum.map(Enum.to_list(1..chunks), fn(x) ->
    text = Faker.Lorem.sentences(%Range{first: 1, last: 5}) |> Enum.join("\n\n")
    chunk_start =
      case x do
        0 ->
          0
        _ ->
          x * 200
      end
    start = Enum.random(chunk_start..(chunk_start+10))
    Repo.insert!(%Annotation{
      text: text,
      start_char: start,
      end_char: Enum.random((start + 10)..(chunk_start + 200)),
      accounts_users_id: Enum.random(1..10),
      documents_docs_id: doc.id
    })
  end)
end
