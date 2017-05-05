alias Notable.Repo
alias Notable.Accounts.User
alias Notable.Documents.{Doc, Annotation}

# Create 10 seed users

for _ <- 1..10 do
  Repo.insert!(%User{
    name: Faker.Name.name,
    email: Faker.Internet.safe_email
  })
end


for _ <- 1..40 do
  Repo.insert!(%Doc{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.sentences(%Range{first: 1, last: 15}) |> Enum.join("\n\n"),
    accounts_users_id: Enum.random(1..10)
  })
end

for _ <- 1..80 do
  text = Faker.Lorem.sentences(%Range{first: 1, last: 2}) |> Enum.join("\n\n")
  Repo.insert!(%Annotation{
    text: text,
    start_char: Enum.random(1..10),
    end_char: Enum.random(10..String.length(text)),
    accounts_users_id: Enum.random(1..10),
    documents_docs_id: Enum.random(1..40)
  })
end
