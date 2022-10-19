--userを作成 ※標準のauth.usersと紐づける
create table if not exists public.users (
  id uuid references auth.users on delete cascade not null primary key,
  username varchar(24) not null unique,
  created_at timestamp with time zone default timezone('utc' :: text, now()) not null,

  constraint username_validation check (char_length(username) >= 1)
);
comment on table public.users is 'Holds all of users profile information';
--テーブルには RLS が設定
alter table public.users enable row level security;
--認証済みユーザのみテーブルからのデータ取得可
--create policy "Public profiles are viewable by everyone." on public.users for select using (true);
create policy "allow select for all authenticated users" on public.users for select using (auth.role() = 'authenticated');
create policy "Can insert user" on public.users for insert with check (auth.uid() = id);
--ユーザ ID が一致する場合にのみテーブル内のデータ変更可
create policy "Can update user" on public.users for update using (auth.uid() = id) with check (auth.uid() = id);
create policy "Can delete user" on public.users for delete using (auth.uid() = id);

--新規ユーザの情報をusersテーブルに挿入するための関数を作成します
create or replace function public.add_user()
returns trigger
language plpgsql
--RLS を回避して関数を実行
security definer
set search_path = public
as $$
begin
  insert into public.users (id, username)
  --テーブルに挿入するvalueとしてnew.raw_user_meta_dataを記述していますが、これはクライアント側で送信された任意のデータを受け取るためのも
  values (new.id, 
  new.raw_user_meta_data->>'username');
  return new;
end;
$$;

--authへのユーザ登録をトリガーに先ほど作成した関数を実行
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.add_user();



--公園情報
create table if not exists public.parks (
    id uuid not null primary key default uuid_generate_v4(),
    --名称
    name varchar(100) not null,
    --市町村
    zip_address1 varchar(40) not null,
    --部落
    zip_address2 varchar(40) not null,
    --メイン画像
    main_image_url text not null,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null
);
comment on table public.parks is 'Holds a summary of park information.';
--リアルタイムに対応
alter publication supabase_realtime add table public.parks;

--
alter table public.parks enable row level security;
create policy "parks are viewable by everyone. " on public.parks for select using (true);
create policy "parks can be inserted by the creator of the everyone. " on public.parks for insert with check (true);
create policy "parks can be updated by the creator of the everyone." on public.parks for update using (true) with check (true);
create policy "parks can be deleted by the creator of the everyone." on public.parks for delete using (true);

--公園情報詳細
create table if not exists public.park_detail (
    park_id uuid references public.parks on delete cascade not null primary key,
    url text,
    image1_url text,
    image2_url text,
    image3_url text,
    image4_url text,
    image5_url text,
    image6_url text,
    image7_url text,
    image8_url text,
    image9_url text,
    image10_url text,
    biko varchar(1000),
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null
);
comment on table public.park_detail is 'Holds all of the park_detail data created by thee users.';

--リアルタイムに対応
alter publication supabase_realtime add table public.park_detail;

alter table public.park_detail enable row level security;
create policy "park_detail are viewable by everyone. " on public.park_detail for select using (true);
create policy "Users can updated their own park_detail." on public.park_detail for update using (true) with check (true);

--新規公園情報をpark_detailテーブルに挿入するための関数を作成します
create or replace function public.add_park_detail()
returns trigger
language plpgsql
--RLS を回避して関数を実行
security definer
set search_path = public
as $$
begin
  insert into public.park_detail (park_id)
  --テーブルに挿入するvalueとしてnew.raw_user_meta_dataを記述していますが、これはクライアント側で送信された任意のデータを受け取るためのも
  values (new.park_id);
  return new;
end;
$$;

--parksへのユーザ登録をトリガーに先ほど作成した関数を実行
create trigger on_parks_created
  after insert on public.parks
  for each row execute procedure public.add_park_detail();


--レビュー
create table if not exists public.reviews (
    park_id uuid references public.parks on delete cascade not null,
    user_id uuid references public.users on delete cascade not null,
    score_h float4 default 0.0,
    score_k float4 default 0.0,
    score_y float4 default 0.0,
    score_o float4 default 0.0,
    comment_h varchar(200),
    comment_k varchar(200),
    comment_y varchar(200),
    comment_o varchar(200),
    taisyo1_3_flg bool default false,
    taisyo4_6_flg bool default false,
    taisyo7_flg bool default false,
    created_at timestamp with time zone default timezone('utc' :: text, now()) not null,
    PRIMARY KEY (park_id, user_id)
);
comment on table public.reviews is 'Holds all of the review data created by thee users.';

--リアルタイムに対応
alter publication supabase_realtime add table public.reviews;

alter table public.reviews enable row level security;
create policy "reviews are viewable by everyone. " on public.reviews for select using (true);
create policy "Users can insert their own reviews." on public.reviews for insert with check (auth.uid() = user_id);
create policy "Users can updated their own reviews." on public.reviews for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can delete own reviews." on public.reviews for delete using (auth.uid() = user_id);

-- --参考
-- create table if not exists public.profiles (
--     id uuid references auth.users on delete cascade not null primary key,
--     username varchar(24) not null unique,
--     created_at timestamp with time zone default timezone('utc' :: text, now()) not null,

--     -- username should be 3 to 24 characters long containing alphabets, numbers and underscores
--     constraint username_validation check (username ~* '^[A-Za-z0-9_]{3,24}$')
-- );
-- comment on table public.profiles is 'Holds all of users profile information';

-- create table if not exists public.messages (
--     id uuid not null primary key default uuid_generate_v4(),
--     profile_id uuid default auth.uid() references public.profiles(id) on delete cascade not null,
--     content varchar(500) not null,
--     created_at timestamp with time zone default timezone('utc' :: text, now()) not null
-- );
-- comment on table public.messages is 'Holds individual messages sent on the app.';

-- -- *** Add tables to the publication to enable real time subscription ***
-- alter publication supabase_realtime add table public.messages;

-- -- Function to create a new row in profiles table upon signup
-- -- Also copies the username value from metadata
-- create or replace function handle_new_user() returns trigger as $$
--     begin
--         insert into public.profiles(id, username)
--         values(new.id, new.raw_user_meta_data->>'username');

--         return new;
--     end;
-- $$ language plpgsql security definer;

-- -- Trigger to call `handle_new_user` when new user signs up
-- create trigger on_auth_user_created
--     after insert on auth.users
--     for each row
--     execute function handle_new_user();