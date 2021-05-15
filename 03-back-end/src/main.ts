import * as express from "express";
import * as cors from "cors";
import Config from "./config/dev";
import { config } from "process";
import CategoryRouter from "./components/category/router";
import * as mysql2 from "mysql2/promise";
import IApplicationResourses from './common/IApplicationResourses.interface';

async function main(){
    const application: express.Application = express();

application.use(cors());
application.use(express.json());

const resourses: IApplicationResourses = {
    databaseConnection: await mysql2.createConnection({
        host: Config.databse.host,
        port: Config.databse.port,
        user: Config.databse.user,
        password: Config.databse.password,
        database: Config.databse.database,
        charset: Config.databse.charset,
        timezone: Config.databse.timezone,
        supportBigNumbers: true,
    }),
}

resourses.databaseConnection.connect;


application.use(Config.server.static.route, express.static(Config.server.static.path, {
    index: Config.server.static.index,
    cacheControl: Config.server.static.cacheControl,
    maxAge: Config.server.static.maxAge,
    etag: Config.server.static.etag,
    dotfiles: Config.server.static.dotfiles,
}));

CategoryRouter.setupRoutes(application, resourses);

application.use((req, res) => {
    res.sendStatus(404)
});

application.listen(Config.server.port);
}

main();
