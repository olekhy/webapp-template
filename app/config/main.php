<?php

declare(strict_types=1);

use Waglpz\Webapp\ExceptionHandler;

\Locale::setDefault('de_DE.utf8');

return [
    'apiVersion'          => '0.1.0',
    'loggingDir'          => __DIR__ . '/../var/log',
    'db'                  => include 'db.php',
    'router'              => include 'router.php',
    'view'                => [
        'templates'  => \dirname(__DIR__) . '/templates/',
        'attributes' => ['webseitenTitle' => '@PROJECT_NAME@ web und REST API application'],
        'layout'     => 'layout.phtml',
    ],
    'viewHelpers'         => [],
    'exception_handler'   => ExceptionHandler::class,
    // uncomment to enable firewall
    //'firewall'            => include 'firewall.php',
    'swagger_scheme_file' => __DIR__ . '/../swagger.json',
];
