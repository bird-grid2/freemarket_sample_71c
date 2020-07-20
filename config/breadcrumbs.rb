crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user.id)
end

crumb :notification do
  link "お知らせ", notification_user_path
  parent :mypage
end

crumb :likes do
  link "いいね！一覧", user_likes_path
  parent :mypage
end

crumb :in_progress do
  link "商品を出品する-取引中-", in_progress_user_path
  parent :mypage
end

crumb :completed do
  link "商品を出品する-売却済み-", completed_user_path
  parent :mypage
end

crumb :purchase do
  link "商品を購入する-取引中-", purchase_user_path
  parent :mypage
end

crumb :purchased do
  link "商品を購入する-購入済み-", purchased_user_path
  parent :mypage
end

crumb :log_out do
  link "ログアウト", log_out_user_path(current_user.id)
  parent :mypage
end