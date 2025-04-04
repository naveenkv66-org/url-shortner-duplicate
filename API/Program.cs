using Azure.Identity;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Add Azure Keyvault

var keyVaultName = builder.Configuration["KeyVaultName"];
builder.Configuration.AddAzureKeyVault(new Uri($"https://{keyVaultName}/vault.azure.net"), new DefaultAzureCredential());

var app = builder.Build();

// Configure the HTTP request pipeline.

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast =  Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast");

app.MapGet("/family", () =>
{
    var family = new[] { "Vasantha","naveen", "divya", "zaina", "lokesh" };
    return family;
})
.WithName("GetFamily");


app.MapGet("/sayhello", () =>
{
   
    return "Hello Wolrd";
})
.WithName("sayhello");

app.MapGet("/helloDeivya", () =>
{

    return "Hello zaina";
})
.WithName("helloDeivya");

app.Run();

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
