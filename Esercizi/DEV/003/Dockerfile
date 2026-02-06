# Fase di build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copia il file di progetto e ripristina le dipendenze
COPY *.csproj ./
RUN dotnet restore

# Copia il resto dei file e compila l'applicazione
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Fase di runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copia i file compilati dalla fase di build
COPY --from=build /app/publish .

# Espone la porta su cui l'app sarà in ascolto
EXPOSE 8080

# Definisce le variabili d'ambiente
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Comando per avviare l'applicazione
ENTRYPOINT ["dotnet", "AspNetCoreApp.dll"]
