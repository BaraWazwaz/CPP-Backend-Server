#include <drogon/drogon.h>
#include "hello.hpp"
#include <iostream>

int main() {
    std::cout << "Starting C++ Server on http://127.0.0.1:8888" << std::endl;

    // Run the server on all local interfaces on port 8888
    drogon::app().addListener("0.0.0.0", 8888);

    std::string message = getHelloWorld();
    // Fallback landing page handler
    drogon::app().registerHandler("/", [&message](const drogon::HttpRequestPtr& req, 
                                          std::function<void (const drogon::HttpResponsePtr&)> &&callback) {
        auto resp = drogon::HttpResponse::newHttpResponse();
        resp->setBody(message);
        resp->setStatusCode(drogon::k200OK);
        callback(resp);
    });

    // Start the event loop
    drogon::app().run();
    return 0;
}
