#! /bin/bash
# Feeling funky with this one...No functions
REPOSITORIES='Repositories'
PROVIDERS='Providers'
FILE='app.php'
TIME=$(date +%Y_%m_%d_%I%M%S)

echo -e "Enter the name of the model$(tput sgr0): \c"
    read

    if [[ ${REPLY,,} == "" ]]; then
        echo "$(tput setaf 3)Warris dis? Enter a valid name for a Laravel model!$(tput sgr0)"
        exit 1
    fi

# Create model
cd app && touch ${REPLY^}.php

# Write model boilerplate code
echo "<?php
namespace App;

use Illuminate\\Database\\Eloquent\\Model;

class ${REPLY^} extends Model
{
    //code...
}
" >> ${REPLY^}.php
echo "$(tput bold)Model created with boilerplate code$(tput sgr0)"

cd .. # Exit to the root directory

# Create Repositories directory along with Contract and Eloquent Repository files
cd app

if [ ! -d "$REPOSITORIES" ]; then
  mkdir $REPOSITORIES
fi

cd $REPOSITORIES
mkdir ${REPLY^} && cd ${REPLY^}
touch ${REPLY^}Contract.php && touch Eloquent${REPLY^}Repository.php

# Write Contract boilerplate code
echo "<?php
namespace App\\$REPOSITORIES\\${REPLY^};

interface ${REPLY^}Contract
{
    public function create(\$request);
    public function findById(\$${REPLY^,}Id);
    public function findAll();
}
" >> ${REPLY^}Contract.php

# Write Eloquent Repository boilerplate code
echo "<?php
namespace App\\$REPOSITORIES\\${REPLY^};

use App\\${REPLY^};
use App\\$REPOSITORIES\\${REPLY^}\\${REPLY^}Contract;

class Eloquent${REPLY^}Repository implements ${REPLY^}Contract
{
    public function create(\$request) {
        \$${REPLY,} = new ${REPLY^};
        // Set \$${REPLY,} properties here...
        \$${REPLY,}->save();
        return \$${REPLY,};
    }
    public function findById(\$${REPLY,}Id) {
        return ${REPLY^}::find(\$${REPLY,}Id);
    }
    public function findAll() {
        return ${REPLY^}::all();
    }
}
" >> Eloquent${REPLY^}Repository.php
echo "$(tput bold)IOC container created with boilerplate code$(tput sgr0)"

cd .. && cd .. # Exit to the app directory

# Create Service Provider
cd $PROVIDERS && touch ${REPLY^}ServiceProvider.php

# Write Service Provider boilerplate code
echo "<?php
namespace App\\$PROVIDERS;

use Illuminate\\Support\\ServiceProvider;

class ${REPLY^}ServiceProvider extends ServiceProvider
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
        \$this->app->bind('App\\Repositories\\${REPLY^}\\${REPLY^}Contract', 'App\\Repositories\\${REPLY^}\\Eloquent${REPLY^}Repository');
    }
}
" >> ${REPLY^}ServiceProvider.php
echo "$(tput bold)Service Provider created with boilerplate code$(tput sgr0)"

cd .. # Exit to the app directory

# Create Contoller
cd Http && cd Controllers && touch ${REPLY^}Controller.php

# Write Controller boilerplate code
echo "<?php
namespace App\\Http\\Controllers;

use Illuminate\\Http\\Request;
use App\\$REPOSITORIES\\${REPLY^}\\${REPLY^}Contract;

class ${REPLY^}Controller extends Controller
{
    protected \$${REPLY,}Model;
    public function __construct(${REPLY^}Contract \$${REPLY,}Contract) {
        \$this->${REPLY,}Model = \$${REPLY,}Contract;
    }
    // Handle your REST affairs here...
}
" >> ${REPLY^}Controller.php
echo "$(tput bold)Controller created with boilerplate code$(tput sgr0)"

cd .. && cd .. && cd .. # Exit to the root directory

cd  database && cd migrations && touch ${TIME}_create_${REPLY,,}s_table.php

#Write Migrations boilerplate
echo "<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Create${REPLY^}sTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('${REPLY,,}s', function (Blueprint \$table) {
            \$table->increments('id');
            \$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('${REPLY,,}s');
    }
}
" >> ${TIME}_create_${REPLY,,}s_table.php
echo "$(tput bold)Migration created with boilerplate codes$(tput sgr0)"

cd .. && cd .. # Exit to the root directory

cd bootstrap 

if [ ! -z $(grep -e "\$app->register(App\\Providers\\"${REPLY^}"ServiceProvider::class);" "$FILE")]; then
    echo "$(tput bold)Service Provider is already registered$(tput sgr0)"
else
    sed -i -e '/\$app->register(App\\Providers\\EventServiceProvider::class);/a \\$app->register(App\\Providers\\'${REPLY^}'ServiceProvider::class);' $FILE 2> /dev/null
    echo "$(tput bold)Service Provider registered successfully inside app.php of the bootstrap directory.$(tput sgr0)"
fi

cd .. # Exit to the root directory
