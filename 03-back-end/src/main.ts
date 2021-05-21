import * as express from "express";
import * as cors from "cors";
import Config from "./config/dev";
import CategoryRouter from "./components/category/router";
import * as mysql2 from "mysql2/promise";
import IApplicationResourses from "./common/IApplicationResourses.interface";
import Router from "./router";
import FeatureRouter from "./components/feature/router";
import CategoryService from "./components/category/service";
import FeatureService from "./components/feature/service";
import ArticleService from "./components/article/service";
import ArticleRouter from "./components/article/router";
import * as fileUpload from "express-fileupload";
import AdministratorService from "./components/admin/service";
import AdministratorRouter from "./components/admin/router";

async function main() {
  const application: express.Application = express();

  application.use(cors());
  application.use(express.json());
  application.use(
    fileUpload({
      limits: {
        fileSize: Config.fileUpload.maxSize,
        files: Config.fileUpload.maxFiles,
      },
      useTempFiles: true,
      tempFileDir: Config.fileUpload.temporaryDirectory,
      uploadTimeout: Config.fileUpload.timeout,
      safeFileNames: true,
      preserveExtension: true,
      createParentPath: true,
      abortOnLimit: true,
    })
  );

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
  };

  resourses.databaseConnection.connect();

  resourses.services = {
    categoryService: new CategoryService(resourses),
    featureService: new FeatureService(resourses),
    articleService: new ArticleService(resourses),
    administratorService: new AdministratorService(resourses),
  };

  application.use(
    Config.server.static.route,
    express.static(Config.server.static.path, {
      index: Config.server.static.index,
      cacheControl: Config.server.static.cacheControl,
      maxAge: Config.server.static.maxAge,
      etag: Config.server.static.etag,
      dotfiles: Config.server.static.dotfiles,
    })
  );

  Router.setupRoutes(application, resourses, [
    new CategoryRouter(),
    new FeatureRouter(),
    new ArticleRouter(),
    new AdministratorRouter(),
  ]);

  application.use((req, res) => {
    res.sendStatus(404);
  });

  application.use((err, req, res, next) => {
    res.status(err.status).send(err.type);
  });

  application.listen(Config.server.port);
}

main();
