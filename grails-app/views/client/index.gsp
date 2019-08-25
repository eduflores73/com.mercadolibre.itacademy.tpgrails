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

<div id="sites" class="container" style="align-items: flex-start">
    <div class="row" id="idPath"></div>

    <br/>
    <select class="custom-select" style="width: 200px" id="selectSites"  onchange="select.fetchData(this.value)">
        <option value="none"> Seleccionar Marca </option>
        <g:each in ="${sites}" var = 'site'>
            <option value ="${site?.id}"> ${site?.name}</option>
            ${site.id} ${site.name} <br/>
        </g:each>
    </select>

    <div class="table-responsive" id="tableCategory" >
        <table id="tabla" border="2"  >
            <thead>
            <tr>
                <td style="color: #005cbf"><h3 aria-atomic="true">Lista de Articulos</h3></td>
            </tr>
            </thead>
                <tr  v-for="category in categories">
                    <td><a href="#" @click = "fetchData1(category.id)" > {{category.name}} </a></td>
                </tr>

        </table>


    </div>

    <br/>
    <div class="row">
        <div class="col-md-6">
            <button id="idBootCrear" type="button" class="btn btn-primary btn-lg btn-block" onclick="select.abrirFormCrearMarca()" class="btn btn-default">Crear Marca</button>
        </div>
        <div class="col-md-6">
            <button id="idBootArticulo" type="button" class="btn btn-primary btn-lg btn-block" onclick="select.abrirFormCrearArticulo()" class="btn btn-default">Crear Articulo</button>

        </div>
    </div>

<br/>
    <form id="idCrearMarca" class="form-check" style="display: none">
    <div class="row">
        <div class="col-md-6">

                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="table-responsive"  id="nameMarca" placeholder="Ingresar el nombre de una Marca">
                    </div>
                </div>

        </div>
        <div class="col-md-6">
            <div>
                <button id="crearMarca" type="reset"  class="btn btn-primary btn-lg btn-block" onclick="select.createMarca()" class="btn btn-default">Crear Marca</button>
            </div>
        </div>
    </div>
    </form>

    <br/>
    <form id="idCreateArticulo" class="form-check" style="display: none">
        <div class="row">
            <div class="col-md-6">

                <div class="form-group row">
                    <div class="col-sm-10">
                        <select class="custom-select" style="width: 450px" id="selectMarcaArticulo">
                            <option value="none"> Seleccionar Marca </option>
                            <g:each in ="${sites}" var = 'site'>
                                <option value ="${site?.id}"> ${site?.name}</option>
                                ${site.id} ${site.name} <br/>
                            </g:each>
                        </select>
                    </div>
                </div>

            </div>

            <div class="col-md-6">
                <div>
                    <input class="table-responsive"   id="nameArticulo" placeholder="Ingresar nombre del Articulo">
                </div>
            </div>

        </div>
        <br/>
        <div class="row">
            <div class="col-md-6">
                <div>
                    <input class="table-responsive"   id="pictureArticulo" placeholder="Ingresar url picture">
                </div>
            </div>
            <div class="col-md-6">
                <div>
                    <button  id="crearArticulo" type="reset" onclick="select.createArticulo()"  class="btn btn-primary btn-lg btn-block" class="btn btn-default">Crear Articulo</button>
                </div>
            </div>
        </div>
    </form>






    <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="nombreCat" class="modal-title">ultimosDatos.name</h3>
            </div>
            <div class="modal-body">
                <p id="idModal"> ID: {{ultimosDatos.id}}</p>
                <p id="nameModal">NAME: {{ultimosDatos.name}}</p>
                <p> PICTURE: <img class="img-fluid" style="max-height: 150px;" id="pictureModal"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-lg btn-primary" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-lg btn-primary" onclick="select.abrirForm()" class="btn btn-default">Edit</button>
                <button type="button" class="btn btn-lg btn-primary" onclick="select.deleteArticulo()" class="btn btn-default" >Delete</button>

            </div>

            <div id="idForm" role="dialog" class="modal-body" style="display: none">
                <form>
                  <div class="form-group">
                     <label for="idName">Name</label>
                     <input class="form-control" id="idName" aria-describedby="emailHelp" placeholder="Nombre Articulo">
                     <small id="emailHelp" class="form-text text-muted"></small>
                  </div>
                    <div class="modal-body">
                        <label for="idPicture">Picture</label>
                        <input class="form-control" id="idPicture" aria-describedby="emailHelp" placeholder="Url Imagen">
                        <small id="emailHelp1" class="form-text text-muted"></small>
                    </div>
                    <br/>
                <button type="submit" onclick="select.editArticulo()" class="btn btn-primary btn-lg btn-block" data-dismiss="modal" class="btn btn-primary">Submit</button>
                <br/>
            </form>

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
                console.log(id);
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
                    alert("Se borro el Articulo");
                    $('#myModal').modal('hide');


                }).catch(function (error) {
                    console.log(error);
                })
            },
            abrirForm: function (){
                document.getElementById("idForm").style.display = "";
            },
            abrirFormCrearMarca: function () {
                document.getElementById("idBootCrear").style.display = 'none';
                document.getElementById("idBootArticulo").style.display = 'none';
                document.getElementById("idCrearMarca").style.display = "";
            },
            abrirFormCrearArticulo: function(){
                document.getElementById("idBootCrear").style.display = 'none';
                document.getElementById("idBootArticulo").style.display = 'none';
                document.getElementById("idCreateArticulo").style.display = "";
            },
            editArticulo: function () {
                var data = {
                    "name": document.getElementById("idName").value,
                    "picture": document.getElementById("idPicture").value,
                   // "total_items_in_this_category": parseInt(this.$refs.totalItemsInput.value),
                    "marca": parseInt(document.getElementById("selectSites").value),
                }
                axios.get('/client/editArticulo',{
                    params: {
                        id : itemId,
                        data: data
                    }
                }).then(function (response) {
                    document.forms['idForm'].reset();
                    alert("Se Edito el Articulo");
                }).catch(function (error) {
                    console.log(error)
                })
            },
            createMarca: function () {
                var dataMarca = {
                    "name": document.getElementById("nameMarca").value,
                }
                axios.get('/client/createMarca',{
                    params: {
                        data: dataMarca
                    }
                }).then(function (response) {
                    document.forms['idForm'].reset();
                    alert("Se creo la marca");
                    document.getElementById("idBootCrear").style.display = "";
                    document.getElementById("idCrearMarca").style.display = 'none';
                }).catch(function (error) {
                    console.log(error)
                })
            },

            createArticulo: function () {
                var dataMarca = {
                    "name": document.getElementById("nameArticulo").value,
                    "picture": document.getElementById("pictureArticulo").value,
                    // "total_items_in_this_category": parseInt(this.$refs.totalItemsInput.value),
                    "marca": parseInt(document.getElementById("selectMarcaArticulo").value),
                }
                axios.get('/client/createArticulo',{
                    params: {
                        data: dataMarca
                    }
                }).then(function (response) {
                    document.forms['idForm'].reset();
                    alert("Se creo el articulo");
                    document.getElementById("idBootCrear").style.display = "";
                    document.getElementById("idBootArticulo").style.display = "";
                    document.getElementById("crearArticulo").style.display = 'none';
                }).catch(function (error) {
                    console.log(error)
                })
            }

        }
    })

</script>

<script>
    document.getElementById("mercadoLibre").style.color = "black";

</script>

</body>
</html>
