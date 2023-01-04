// camel-k: language=java

import org.apache.camel.main.Main;

import org.apache.camel.CamelContext;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.impl.DefaultCamelContext;

public class TempsAttenteAgenceCamel {

    public static void main() throws Exception {
        try (CamelContext camel = new DefaultCamelContext()) {
            
            camel.addRoutes(new TempsAttenteRouteBuilder());
            camel.start();
        } 
        catch (Exception e) {

            System.out.println("L'erreur suivante a été soulevé : " + e.toString());

        }
    }

    public static class TempsAttenteRouteBuilder extends RouteBuilder {
        @Override
        public void configure() {
            from("timer://foo?preiod=5000")
                    .to("http:8080/temps-attente/agence/4161")
                    .log("The body was - ${body}");

            /* from("timer:mytimer?repeatCount=1")
                    .setBody(simple("${null}"))
                    .setHeader("agence", constant("4161"))
                    .toD("localhost:8080/temps-attente/agence/${header.agence}" + "?httpMethod=GET")
                    .log("The body was - ${body}"); */
        }
    }
    
}
