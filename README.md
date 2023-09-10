# bookmyshow
just like a book my show app



//docker exec -it bms-postgres-container bash;
//psql -U bms_user -d bms_db;
// select * from bms_schema.city;

//docker exec -it bms-postgres-container bash -c "psql -U //bms_user -d bms_db -c 'SELECT * FROM bms_schema.city;'"
//docker exec -it bms-postgres-container bash -c "psql -U bms_user -d bms_db"  \dn
//docker image save mydebugimage > mydebugimage.tar

//docker run -it --rm mydebugimage go run /app/cmd/main.go
//docker run -it 90 go run /app/cmd/main.go

//curl http://localhost:8080/api/hello

//http://localhost:8080/api/hello

//curl -X POST -H "Content-Type: application/json" -d '{"address": "1600 Amphitheatre Parkway, Mountain View, CA"}' http://localhost:8090/get-location

//curl -LO https://github.com/deepmap/oapi-codegen/releases/download/v1.8.1/oapi-codegen_v1.8.1_darwin_amd64
//chmod +x oapi-codegen_v1.8.1_darwin_amd64
//mv oapi-codegen_v1.8.1_darwin_amd64 /Users/rahulprabhakar/go/bin/oapi-codegen
oapi-codegen --version
//echo 'export PATH=$PATH:/Users/rahulprabhakar/go/bin' >> ~/.bashrc


bash-3.2$ cd /Users/rahulprabhakar/go
bash-3.2$ pwd
/Users/rahulprabhakar/go
bash-3.2$ ls
bin	pkg
bash-3.2$ cd bin
bash-3.2$ ls
go-outline	goimports	gopls		oapi-codegen
bash-3.2$ rm -rf oapi-codegen
bash-3.2$ curl -LO https://github.com/deepmap/oapi-codegen/releases/download/v1.8.1/oapi-codegen_v1.8.1_darwin_amd64
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100     9  100     9    0     0     14      0 --:--:-- --:--:-- --:--:--    14
bash-3.2$ sudo mv oapi-codegen_v1.8.1_darwin_amd64 /usr/local/bin/oapi-codegen
bash-3.2$ oapi-codegen --version
bash: /Users/rahulprabhakar/go/bin/oapi-codegen: No such file or directory
bash-3.2$ 
export PATH=$PATH:/usr/local/bin

inspect folder structure
//docker run --rm -it bookmyshow_bms_backend /bin/sh 