package com.mercadolibre.itacademy

import grails.converters.JSON
import groovy.json.JsonSlurper

class ClientController {

   /*     def index() {

            def url = new URL("https://api.mercadolibre.com/sites")
            def connection = (HttpURLConnection) url.openConnection()
            connection.setRequestMethod("GET")
            connection.setRequestProperty("Accept", "application/json")
            connection.setRequestProperty("User-Agent", "Mozilla/5.0")

            JsonSlurper json = new JsonSlurper()
            def sites = json.parse(connection.getInputStream())
            [sites: sites]
        }

    def listCategory (String id){

        def url = new URL("https://api.mercadolibre.com/sites/"+id + "/categories")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def subCategories = json.parse(connection.getInputStream())
        def resultado = [categories: subCategories]

        render resultado as JSON

    }

    def listSubCategory (String id){

        def url = new URL("https://api.mercadolibre.com/categories/"+id)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def categories = json.parse(connection.getInputStream())
        def resultado = [categories: categories]
        if(resultado != null) {
            render resultado as JSON
        }

    }
*/
    def index() {

        def url = new URL("http://localhost:8080/marcas")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def sites = json.parse(connection.getInputStream())
        [sites: sites]
    }

    def listCategory (String id){

        def url = new URL("http://localhost:8080/marcas/"+id + "/articulos")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def subCategories = json.parse(connection.getInputStream())
        def resultado = [categories: subCategories]

        render resultado as JSON

    }

    def listSubCategory (String id){

        def url = new URL("http://localhost:8080/articulos/"+id )
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def categories = json.parse(connection.getInputStream())
        def resultado = [categories: categories]
        if(resultado != null) {
            render resultado as JSON
        }

    }

    def deleteArticulo (String id){

        def url = new URL("http://localhost:8080/articulos/"+id )
        println(url)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("DELETE")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        connection.getInputStream()
        //def resultado = [categories: categories]
        //if(resultado != null) {
            render "OK"
        //}

    }




}
