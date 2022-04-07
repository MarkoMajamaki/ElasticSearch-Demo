using Microsoft.AspNetCore.Mvc;
using Nest;

namespace Demo.Api;

[ApiController]
[Route("[controller]")]
public class UserController : ControllerBase
{   
    private readonly ILogger<UserController> _logger;
    private readonly IElasticClient _elasticClient;

    public UserController(ILogger<UserController> logger, IElasticClient elasticClient)
    {
        _logger = logger;
        _elasticClient = elasticClient;
    }

    [HttpGet("{id}")]
    public async Task<User?> Get(string id)
    {
        _logger.LogDebug("Get user with id: {id}");

        var response = await _elasticClient.SearchAsync<User>(s => s
        .Index("users")
        .Query(q => q.Match(m => m.Field(f => f.Name).Query(id))));

        return response?.Documents?.FirstOrDefault();
    }

    [HttpPost]
    public async Task<string> Post([FromBody] User newUser)
    {
        _logger.LogDebug("Add new user");

        var response = await _elasticClient.IndexAsync<User>(newUser, x => x.Index("users"));
        return response.Id;
    }
}