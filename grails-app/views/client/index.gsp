<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <title> Api Mercado Libre IT-Academy</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<body>

<div class="row" id="idPath"></div>

<br/>
<div id="sites">
    <select style="align-items: flex-start" class="alert-dark" id="selectSites" onchange="select.fetchData(this.value)">
        <g:each in ="${sites}" var = 'site'>
            <option  value ="${site?.id}"> ${site?.name}</option>

            ${site.id} ${site.name} <br/>
        </g:each>
    </select>

    <div class="table table-striped">
        <table id="tabla" border="2"  >
            <thead>
            <tr>
                <td style="color: #005cbf">Categoria</td>
            </tr>
            </thead>
                <tr v-for="category in categories">
                    <td><a href="#" @click = "fetchData1(category.id)" > {{category.name}} </a></td>
                </tr>

        </table>


    </div>
<div id="idForm" style="display: none">
    <form>
        <div class="form-group">
            <label for="exampleInputEmail1">Nombre Marca</label>
            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Nombre Marca">
            <small id="emailHelp" class="form-text text-muted"></small>
        </div>
        <button type="submit" class="btn btn-primary">Crear</button>
        <br/>
    </form>

</div>

    <br/>
    <button type="button" onclick="select.crearMarca()" class="btn btn-default" data-dismiss="modal">Crear Marca</button>
    <button type="button" onclick="select.crearArticulo()" class="btn btn-default" data-dismiss="modal">Crear Articulo</button>

    <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 id="nombreCat" class="modal-title">ultimosDatos.name</h4>
            </div>
            <div class="modal-body">
                <p id="idModal"> ID: {{ultimosDatos.id}}</>
                <p id="nameModal">NAME: {{ultimosDatos.name}}</p>
                <p> PICTURE: <img class="img-fluid" style="max-height: 150px;" id="pictureModal"></p>>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                <button type="button" onclick="select.deleteArticulo()" class="btn btn-default" >Eliminar</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Editar</button>
            </div>
        </div>

    </div>
</div>

</div>



<script>
    var itemId;
    var select = new Vue({
        el: '#sites',
        data: {
            categories: [],
            ultimosDatos: [],
            primerPath: ""
        },
        methods: {
            fetchData: function (id) {
                axios.get('/client/listCategory', {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    select.categories = response.data.categories

                    idSelect = document.getElementById("selectSites");
                    nombre = idSelect.options[idSelect.selectedIndex].innerHTML

                    document.getElementById("idPath").innerHTML = "";
                    document.getElementById("idPath").innerHTML = "<a href='#' onclick='crearPath('"+idSelect.value+"')'>"+nombre+" </a>";
                    primerPath = "<a href='#' onclick=select.crearPath('"+idSelect.value+"')>"+nombre+" </a>";
                }).catch(function (error) {
                    console.log(error);
                })
            },
            fetchData1: function (id) {
                itemId=id;
                axios.get('/client/listSubCategory', {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    var array = response.data.categories.children_categories
                    if(typeof array !== 'undefined' && array.length > 0){
                        select.categories = response.data.categories.children_categories
                        document.getElementById("idPath").innerHTML = document.getElementById('idPath').innerHTML + " -> <a href='#' onclick=select.crearPath1('"+ response.data.categories.id +"')>"+response.data.categories.name+" </a>";

                    }
                    else
                    {
                        select.ultimosDatos = response.data.categories;
                        document.getElementById("nombreCat").innerHTML = select.ultimosDatos.name;
                        document.getElementById("idModal").innerHTML = select.ultimosDatos.id;
                        document.getElementById("nameModal").innerHTML = select.ultimosDatos.name;
                        document.getElementById("pictureModal").src = select.ultimosDatos.picture;
                     //   $('#myModal').modal({show: false});
                        $('#myModal').modal('show');
                    }


                }).catch(function (error) {
                    console.log(error);
                })
              },
            crearPath: function (id) {
                axios.get('/client/listCategory', {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    select.categories = response.data.categories
                    document.getElementById("idPath").innerHTML = "";
                    document.getElementById("idPath").innerHTML = "<a href='#' onclick='crearPath('"+id+"')'>";
                }).catch(function (error) {
                    console.log(error);
                })
            },
            crearPath1: function (id) {
                axios.get('/client/listSubCategory', {
                    params: {
                        id: id
                    }
                }).then(function (response) {
                    document.getElementById("idPath").innerHTML = "";
                    document.getElementById("idPath").innerHTML = primerPath;
                    for(i=0; i < response.data.categories.path_from_root.length ; i++){
                           document.getElementById("idPath").innerHTML = document.getElementById('idPath').innerHTML + " -> <a href='#' onclick=select.crearPath1('"+ response.data.categories.path_from_root[i].id +"')>"+response.data.categories.path_from_root[i].name+" </a>";
                    }
                    var array = response.data.categories.children_categories
                    if(typeof array !== 'undefined' && array.length > 0){
                        select.categories = response.data.categories.children_categories
                    }
                    else
                    {
                        select.ultimosDatos = response.data.categories;
                        document.getElementById("nombreCat").innerHTML = select.ultimosDatos.name;
                        document.getElementById("idModal").innerHTML = select.ultimosDatos.id;
                        document.getElementById("nameModal").innerHTML = select.ultimosDatos.name;
                        document.getElementById("pictureModal").src = select.ultimosDatos.picture;
                        //   $('#myModal').modal({show: false});
                        $('#myModal').modal('show');
                    }


                }).catch(function (error) {
                    console.log(error);
                })
            },
            deleteArticulo: function () {
                axios.get('/client/deleteArticulo', {
                    params: {
                        id: itemId
                    }
                }).then(function (response) {
                    select.statusCode = response.data.resultado;
                    $('#myModal').modal('hide');

                }).catch(function (error) {
                    console.log(error);
                })
            },
            crearMarca: function () {
                document.getElementById("idForm").style.display = "";
                //falta tomar el valor y hacer el post
            }

        }
    })

</script>

<script>
    document.getElementById("mercadoLibre").style.color = "black";
</script>

</body>
</html>