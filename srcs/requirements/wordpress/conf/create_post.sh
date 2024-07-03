#!/bin/bash

WP_PATH="/var/www/wordpress"

POST1_AUTHOR="2"
POST1_TITLE="Lorem Ipsum"
POST1_CONTENT="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ultricies lacus sed turpis tincidunt id aliquet. Nulla at volutpat diam ut venenatis tellus in metus. Vitae ultricies leo integer malesuada nunc vel risus. Amet tellus cras adipiscing enim eu turpis. Ornare arcu dui vivamus arcu felis bibendum. Et ligula ullamcorper malesuada proin libero nunc consequat interdum varius. Sed cras ornare arcu dui vivamus arcu felis. Euismod elementum nisi quis eleifend quam adipiscing vitae. Neque volutpat ac tincidunt vitae semper quis lectus nulla at. Neque gravida in fermentum et.

Id aliquet lectus proin nibh nisl condimentum id venenatis. Neque gravida in fermentum et sollicitudin ac. Libero enim sed faucibus turpis in eu mi bibendum neque. Tincidunt tortor aliquam nulla facilisi. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi. Proin sagittis nisl rhoncus mattis rhoncus urna neque. Lectus proin nibh nisl condimentum id venenatis a condimentum. Enim tortor at auctor urna nunc id cursus metus aliquam. Nibh cras pulvinar mattis nunc. Nunc non blandit massa enim. Orci phasellus egestas tellus rutrum. Facilisis sed odio morbi quis. Eget duis at tellus at urna condimentum mattis pellentesque. Diam maecenas ultricies mi eget mauris pharetra. Quis auctor elit sed vulputate mi sit amet mauris. Velit scelerisque in dictum non. Volutpat odio facilisis mauris sit amet massa.

At lectus urna duis convallis convallis tellus id. Suspendisse ultrices gravida dictum fusce ut placerat. Volutpat maecenas volutpat blandit aliquam etiam. Aliquam etiam erat velit scelerisque in. Pharetra et ultrices neque ornare. Elementum curabitur vitae nunc sed velit dignissim sodales ut. Sed blandit libero volutpat sed cras. Massa vitae tortor condimentum lacinia quis vel. Rhoncus urna neque viverra justo nec ultrices dui sapien eget. Condimentum lacinia quis vel eros. Fermentum leo vel orci porta non pulvinar. Nibh mauris cursus mattis molestie a iaculis at erat. Purus faucibus ornare suspendisse sed nisi lacus sed viverra tellus."

POST2_AUTHOR="1"
POST2_TITLE="42 Inception"
POST2_CONTENT="<img src='https://www.meme-arsenal.com/memes/7a6bbb1ef560defa6f02c31e3ae20a92.jpg' alt='42 Inception'>"

create_post() {
    local author=$1
    local title=$2
    local content=$3
    local thumbnail_url=$4

    POST_ID=$(wp post create --path="$WP_PATH" \
        --post_author="$author" \
        --post_title="$title" \
        --post_content="$content" \
        --post_status="publish" \
        --porcelain \
        --allow-root)

}

create_post "$POST1_AUTHOR" "$POST1_TITLE" "$POST1_CONTENT"
create_post "$POST2_AUTHOR" "$POST2_TITLE" "$POST2_CONTENT"

echo "Both posts created successfully!\n"
