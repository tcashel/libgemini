#include <iostream>
#include <lift/lift.hpp>

#include "simdjson.h"

#include "consts.h"

int main()
{
    lift::request request{consts::urls::ticker};
    std::cout << "Requesting " << consts::urls::ticker << std::endl;
    const auto& response = request.perform();
    std::cout << response.data() << std::endl;

    simdjson::padded_string_view respomnse_padded(response.data(), response.data().size() + simdjson::SIMDJSON_PADDING);
    simdjson::dom::parser        parser;
    simdjson::dom::object        object;

    auto error = parser.parse(respomnse_padded).get(object);
    if (error)
    {
        std::cerr << error << std::endl;
        return EXIT_FAILURE;
    }

    std::cout << "Success\n" << std::endl;
    for (auto [key, value] : object)
    {
        std::cout << key << " = " << value << std::endl;
    }

    return EXIT_SUCCESS;
}
