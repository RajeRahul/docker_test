@echo off

echo makemigrations
docker exec web4 python manage.py makemigrations

echo migration
docker exec web4 python manage.py migrate

echo copy movies
docker cp dataset/movie.json mongodb4:movie.json

echo copy books
docker cp dataset/book.json mongodb4:book.json

echo copy animes
docker cp dataset/anime2.json mongodb4:anime2.json

echo import movie.json
docker exec mongodb4 mongoimport -d recommendation_system_db -c recommendation_webapp_movie --file movie.json --jsonArray

echo import book.json
docker exec mongodb4 mongoimport -d recommendation_system_db -c recommendation_webapp_book --file book.json --jsonArray

echo import anime2.json
docker exec mongodb4 mongoimport -d recommendation_system_db -c recommendation_webapp_anime2 --file anime2.json --jsonArray

echo all imports done successfully!
echo Go to http://127.0.0.1:8000/recommendations_webapp_home/ to try the application

pause
