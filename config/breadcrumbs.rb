crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", user_path(current_user.id)
end

crumb :likes do
  link "いいね！一覧", user_likes_path
  parent :mypage
end

crumb :sign_out do
  link "ログアウト", edit_user_path(current_user.id)
  parent :mypage
end