FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

COPY *.csproj .
RUN dotnet restore --use-current-runtime

COPY . .
RUN dotnet publish --use-current-runtime --self-contained false --no-restore -o /app


FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [ "dotnet", "dotnetapp.dll" ]