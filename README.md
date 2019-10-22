# Migracions

Les migracions no es fan automàticament a la Bdd. El problema és que quan
es volen executar els dos contenidors la web ha de fer les migracions a la
BdD però aquesta no sempre està disponible

Per això fins que no trobi una solució millor, genero el fitxer SQL amb les migracions:

```sql
dotnet ef migrations script -o migrate.sql --startup-project ../Demos/BusinessContext.Demo/ --idempotent
```

I l'aplico a la Bdd quan s'inicia
