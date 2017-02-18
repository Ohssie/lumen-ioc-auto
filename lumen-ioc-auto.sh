#! /bin/bash
# Feeling funky with this one...No functions
REPOSITORIES='Repositories'
PROVIDERS='Providers'

echo -e "Enter the name of the model$(tput sgr0): \c"
    read

    if [[ ${REPLY,,} == "" ]]; then
        echo "$(tput setaf 3)Warris dis? Enter a valid name for a Laravel model!$(tput sgr0)"
        exit 1
    fi

# Create model
cd app && touch ${REPLY}.php

# Write model boilerplate code
echo "<?php

namespace App;

use Illuminate\\Database\\Eloquent\\Model;

class ${REPLY} extends Model
{

}
" >> ${REPLY}.php
echo "$(tput bold)Model created with boilerplate code$(tput sgr0)"

cd .. # Exit to the root directory

# Create Repositories directory along with Contract and Eloquent Repository files
cd app && mkdir $REPOSITORIES
cd $REPOSITORIES
mkdir ${REPLY} && cd ${REPLY}
touch ${REPLY}Contract.php && touch Eloquent${REPLY}Repository.php

# Write Contract boilerplate code
echo "<?php
namespace App\\$REPOSITORIES\\${REPLY};

interface ${REPLY}Contract
{
    public function create(\$request);
    public function findById(\$${REPLY,}Id);
    public function findAll();
}
" >> ${REPLY}Contract.php

# Write Eloquent Repository boilerplate code
echo "<?php

namespace App\\$REPOSITORIES\\${REPLY};

use App\\${REPLY};
namespace App\\$REPOSITORIES\\${REPLY}\\${REPLY}Contract;

class Eloquent${REPLY}Repository implements ${REPLY}Contract
{
    public function create(\$request) {
        \$${REPLY,} = new ${REPLY};
        // Set \$${REPLY,} properties here...
        \$${REPLY,}->save();
        return \$${REPLY,};
    }

    public function findById(\$${REPLY,}Id) {
        return ${REPLY}::find(\$${REPLY,}Id);
    }

    public function findAll() {
        return ${REPLY}::all();
    }
}
" >> Eloquent${REPLY}Repository.php
echo "$(tput bold)IOC container created with boilerplate code$(tput sgr0)"

cd .. && cd .. # Exit to the app directory

# Create Service Provider
cd $PROVIDERS && touch ${REPLY}ServiceProvider.php

# Write Service Provider boilerplate code
echo "<?php

namespace App\\$PROVIDERS;

use Illuminate\\Support\\ServiceProvider;

class ${REPLY}ServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot() {
        //
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register() {
        \$this->app->bind('App\\Repositories\\${REPLY}\\${REPLY}Contract', 'App\\Repositories\\${REPLY}\\Eloquent${REPLY}Repository');
    }
}
" >> ${REPLY}ServiceProvider.php
echo "$(tput bold)Service Provider created with boilerplate code. Dont forget to bind it in bootstrap/app.php$(tput sgr0)"
# Remind to add it to bootstrap/app.php

cd .. # Exit to the app directory

# Create Contoller
cd Http && cd Controllers && touch ${REPLY}Controller.php

# Write Controller boilerplate code
echo "<?php

namespace App\\Http\\Controllers;

use Illuminate\\Http\\Request;

use App\\$REPOSITORIES\\${REPLY}\\${REPLY}Contract;

class ${REPLY}Controller extends Controller
{
    protected \$${REPLY,}Model;
    public function __construct(${REPLY}Contract \$${REPLY,}Contract) {
        \$this->${REPLY,}Model = \$${REPLY,}Contract;
    }

    // Handle your rest affairs here...
}
" >> ${REPLY}Controller.php
echo "$(tput bold)Controller created with boilerplate code$(tput sgr0)"

cd .. && cd .. && cd .. # Exit to the root directory
