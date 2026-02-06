using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddEndpointsApiExplorer();
//builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    
}

// Route principale
app.MapGet("/", () => new
{
    Message = "Benvenuto nell'applicazione ASP.NET Core!",
    Timestamp = DateTime.UtcNow,
    Version = "1.0.0"
})
.WithName("GetRoot");

// Route per lista clienti
app.MapGet("/api/customers", () =>
{
    var customers = new[]
    {
        new { Id = 1, Name = "Rossi SpA", Email = "info@rossi.it", City = "Milano" },
        new { Id = 2, Name = "Bianchi Srl", Email = "contact@bianchi.it", City = "Roma" },
        new { Id = 3, Name = "Verdi & Co", Email = "info@verdi.it", City = "Torino" },
        new { Id = 4, Name = "Neri Industries", Email = "sales@neri.it", City = "Napoli" }
    };
    return Results.Ok(customers);
})
.WithName("GetCustomers");

// Route per singolo cliente
app.MapGet("/api/customers/{id}", (int id) =>
{
    var customers = new[]
    {
        new { Id = 1, Name = "Rossi SpA", Email = "info@rossi.it", City = "Milano", Revenue = 1500000 },
        new { Id = 2, Name = "Bianchi Srl", Email = "contact@bianchi.it", City = "Roma", Revenue = 2300000 },
        new { Id = 3, Name = "Verdi & Co", Email = "info@verdi.it", City = "Torino", Revenue = 980000 },
        new { Id = 4, Name = "Neri Industries", Email = "sales@neri.it", City = "Napoli", Revenue = 3100000 }
    };
    
    var customer = customers.FirstOrDefault(c => c.Id == id);
    return customer != null ? Results.Ok(customer) : Results.NotFound(new { Error = "Cliente non trovato" });
})
.WithName("GetCustomer");

// Route POST per echo
app.MapPost("/api/echo", ([FromBody] object data) =>
{
    return Results.Ok(new
    {
        Message = "Echo ricevuto",
        Data = data,
        Timestamp = DateTime.UtcNow
    });
})
.WithName("Echo");

// Route per informazioni sistema
app.MapGet("/api/info", () =>
{
    return Results.Ok(new
    {
        DotNetVersion = Environment.Version.ToString(),
        OSVersion = Environment.OSVersion.ToString(),
        MachineName = Environment.MachineName,
        ProcessorCount = Environment.ProcessorCount,
        WorkingSet = Environment.WorkingSet,
        AspNetCoreEnvironment = app.Environment.EnvironmentName
    });
})
.WithName("GetInfo");

// Route per calcoli matematici
app.MapGet("/api/calculate", ([FromQuery] double num1, [FromQuery] double num2, [FromQuery] string op) =>
{
    try
    {
        double result = op switch
        {
            "add" => num1 + num2,
            "sub" => num1 - num2,
            "mul" => num1 * num2,
            "div" => num2 != 0 ? num1 / num2 : throw new DivideByZeroException("Divisione per zero"),
            _ => throw new ArgumentException("Operazione non valida")
        };

        return Results.Ok(new
        {
            Num1 = num1,
            Num2 = num2,
            Operation = op,
            Result = result
        });
    }
    catch (Exception ex)
    {
        return Results.BadRequest(new { Error = ex.Message });
    }
})
.WithName("Calculate");

// Health check
app.MapGet("/health", () =>
{
    return Results.Ok(new
    {
        Status = "OK",
        Timestamp = DateTime.UtcNow,
        Uptime = TimeSpan.FromMilliseconds(Environment.TickCount64)
    });
})
.WithName("HealthCheck");

// Route per meteo (esempio)
app.MapGet("/api/weather", () =>
{
    var forecasts = Enumerable.Range(1, 5).Select(index =>
        new
        {
            Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            TemperatureC = Random.Shared.Next(-10, 35),
            Summary = new[] { "Soleggiato", "Nuvoloso", "Piovoso", "Nevoso", "Ventoso" }[Random.Shared.Next(5)]
        })
        .ToArray();

    return Results.Ok(forecasts);
})
.WithName("GetWeather");

app.Run();
