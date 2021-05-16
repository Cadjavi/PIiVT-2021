import IApplicationResourses from "./IApplicationResourses.interface";
import * as express from "express";

export default interface IRouter {
  setupRoutes(
    application: express.Application,
    resourses: IApplicationResourses
  );
}
