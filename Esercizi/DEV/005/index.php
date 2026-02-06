<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicazione PHP in Docker</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        .info-box {
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .info-box strong {
            color: #ffd700;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        th {
            background: rgba(255, 255, 255, 0.1);
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐳 Applicazione PHP in Docker</h1>
        
        <div class="info-box">
            <strong>Versione PHP:</strong> <?php echo phpversion(); ?>
        </div>
        
        <div class="info-box">
            <strong>Server:</strong> <?php echo $_SERVER['SERVER_SOFTWARE']; ?>
        </div>
        
        <div class="info-box">
            <strong>Data e ora:</strong> <?php echo date('d/m/Y H:i:s'); ?>
        </div>
        
        <div class="info-box">
            <strong>Hostname:</strong> <?php echo gethostname(); ?>
        </div>

        <h2>Informazioni Server</h2>
        <table>
            <tr>
                <th>Variabile</th>
                <th>Valore</th>
            </tr>
            <tr>
                <td>Document Root</td>
                <td><?php echo $_SERVER['DOCUMENT_ROOT']; ?></td>
            </tr>
            <tr>
                <td>Server Name</td>
                <td><?php echo $_SERVER['SERVER_NAME']; ?></td>
            </tr>
            <tr>
                <td>Server Port</td>
                <td><?php echo $_SERVER['SERVER_PORT']; ?></td>
            </tr>
            <tr>
                <td>User Agent</td>
                <td><?php echo $_SERVER['HTTP_USER_AGENT']; ?></td>
            </tr>
        </table>

        <h2>Test Database Connection</h2>
        <div class="info-box">
            <?php
            $extensions = get_loaded_extensions();
            if (in_array('mysqli', $extensions)) {
                echo "✅ Estensione MySQLi: <strong>Disponibile</strong>";
            } else {
                echo "❌ Estensione MySQLi: Non disponibile";
            }
            echo "<br>";
            if (in_array('pdo_mysql', $extensions)) {
                echo "✅ Estensione PDO MySQL: <strong>Disponibile</strong>";
            } else {
                echo "❌ Estensione PDO MySQL: Non disponibile";
            }
            ?>
        </div>
    </div>
</body>
</html>
