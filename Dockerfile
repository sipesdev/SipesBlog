# Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY SipesBlog.csproj .
COPY SipesBlog.sln .

RUN dotnet restore "SipesBlog.csproj"
COPY . .
RUN dotnet publish "SipesBlog.csproj" -c Release -o /publish

# Deploy
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 8080
COPY --from=build /publish .

ENTRYPOINT [ "dotnet", "SipesBlog.dll" ]