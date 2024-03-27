# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:latest AS build-env

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Restore dependencies and build the .NET Core application
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:latest
WORKDIR /app
COPY --from=build-env /app/out .

# Run the .NET Core application
CMD ["dotnet", "Program.dll"]
