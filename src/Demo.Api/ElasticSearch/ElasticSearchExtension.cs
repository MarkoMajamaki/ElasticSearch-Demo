using Nest;

namespace Demo.Api;

public static class ElasticSearchExtension
{
    public static void AddElasticSearch(this IServiceCollection services, IConfiguration configuration)
    {        
        string url = configuration["ElasticSearch:Url"];

        var settings = new ConnectionSettings(new Uri(url));

        var client = new ElasticClient(settings);

        services.AddSingleton<IElasticClient>(client);
    }
} 