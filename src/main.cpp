#include <iostream>
#include <lift/lift.hpp>

int main()
{
    {
        std::string btc_ticker_request = "https://api.sandbox.gemini.com/v2/ticker/btcusd";
        lift::request request{btc_ticker_request};
        std::cout << "Requesting " << btc_ticker_request << std::endl;
        const auto& response = request.perform();
        std::cout << response.data() << std::endl;
    }
}
