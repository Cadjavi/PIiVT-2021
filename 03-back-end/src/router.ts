import * as express from "express";
import IApplicationResourses from './common/IApplicationResourses.interface';
import IRouter from './common/IRouter.interface';

export default class Router {
    static setupRoutes(application: express.Application, resourses: IApplicationResourses, routers: IRouter[] ){
        for(const router of routers) {
            router.setupRoutes(application, resourses);
        }
    }
}