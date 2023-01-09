///usr/bin/env jbang "$0" "$@" ; exit $?
// Use org.apache.camel:camel-bom:3.19.0@pom in order to avoid repeating the version in each line 
//DEPS org.apache.camel:camel-core:3.19.0
//DEPS org.apache.camel:camel-main:3.19.0
//DEPS org.apache.camel:camel-stream:3.19.0
//DEPS org.apache.camel:camel-http:3.19.0
//DEPS org.apache.camel:camel-jackson:3.19.0

import org.apache.camel.*;
import org.apache.camel.builder.*;
import org.apache.camel.main.*;
import org.apache.camel.model.dataformat.JsonLibrary;

import static java.lang.System.*;

public class TempsAttenteAgenceCamel {

    public static void main(String... args) throws Exception {
        out.println("Hello World");
        out.println("Running camel route...");

        Main main = new Main();

        // Configuration de la route 
        main.configure().addRoutesBuilder(new RouteBuilder() {
            public void configure() throws Exception {
                from("timer://foo?period=5000")
                .to("http://localhost:8080/temps-attente/agences")
                .unmarshal().json(JsonLibrary.Jackson)
                .process(exchange -> {
                    // On print la réponse
                    out.println(exchange.getIn().getBody());
                });
                
            }
        });
        main.run();
    }
}
