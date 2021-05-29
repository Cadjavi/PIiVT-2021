import * as express from "express";
import CategoryService from "./service";
import CategoryController from "./controller";
import IApplicationResourses from "../../common/IApplicationResourses.interface";
import IRouter from "../../common/IRouter.interface";
import FeatureService from "./service";
import FeatureController from "./controller";

export default class FeatureRouter implements IRouter {
  public setupRoutes(
    application: express.Application,
    resourses: IApplicationResourses
  ) {
    
    const featureController: FeatureController = new FeatureController(
      resourses
    );

    application.get(
      "/feature/:id",
      featureController.getById.bind(featureController)
    );
    application.get(
      "/category/:cid/feature",
      featureController.getAllInCategory.bind(featureController)
    );
    application.post(
        "/feature",
        featureController.add.bind(featureController)
    );
    application.put(
        "/feature/:id",
        featureController.edit.bind(featureController)
    )
  }
}
