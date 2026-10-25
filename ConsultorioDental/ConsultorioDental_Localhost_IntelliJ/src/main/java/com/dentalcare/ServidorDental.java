package com.dentalcare;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;


public final class ServidorDental {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", 8080), 0);
        server.createContext("/", ServidorDental::servir);
        server.start();
        System.out.println("DentalCare disponible en http://localhost:8080/");
        System.out.println("Detén la ejecución desde IntelliJ para cerrar el servidor.");
    }

    private static void servir(HttpExchange exchange) throws IOException {
        try {
            if (!"GET".equals(exchange.getRequestMethod()) && !"HEAD".equals(exchange.getRequestMethod())) {
                responder(exchange, 405, "Solo se permite GET", "text/plain; charset=utf-8");
                return;
            }
            String path = exchange.getRequestURI().getPath();
            if (path.equals("/")) path = "/index.html";
            if (!(path.equals("/index.html") || path.equals("/css/styles.css") || path.equals("/js/app.js"))) {
                responder(exchange, 404, "Archivo no encontrado", "text/plain; charset=utf-8");
                return;
            }
            String resourcePath = "/web" + path;
            try (InputStream stream = ServidorDental.class.getResourceAsStream(resourcePath)) {
                if (stream == null) {
                    responder(exchange, 404, "Archivo no encontrado", "text/plain; charset=utf-8");
                    return;
                }
                byte[] content = stream.readAllBytes();
                String type = path.endsWith(".css") ? "text/css; charset=utf-8"
                        : path.endsWith(".js") ? "text/javascript; charset=utf-8"
                        : "text/html; charset=utf-8";
                exchange.getResponseHeaders().set("Content-Type", type);
                exchange.getResponseHeaders().set("Cache-Control", "no-store");
                exchange.sendResponseHeaders(200, "HEAD".equals(exchange.getRequestMethod()) ? -1 : content.length);
                if (!"HEAD".equals(exchange.getRequestMethod())) {
                    try (OutputStream os = exchange.getResponseBody()) { os.write(content); }
                } else exchange.close();
            }
        } finally { exchange.close(); }
    }

    private static void responder(HttpExchange exchange, int code, String message, String type) throws IOException {
        byte[] content = message.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", type);
        exchange.sendResponseHeaders(code, content.length);
        try (OutputStream os = exchange.getResponseBody()) { os.write(content); }
    }
}
