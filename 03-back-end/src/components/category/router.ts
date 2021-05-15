import * as express from 'express';
import CategoryService from './service';
import CategoryController from './controller';
import IApplicationResourses from '../../common/IApplicationResourses.interface';

export default class CategoryRouter {
    public static setupRoutes(application: express.Application, resourses: IApplicationResourses){
        const categoryService: CategoryService = new CategoryService(resourses.databaseConnection);
        const categoryController: CategoryController = new CategoryController(categoryService);

        application.get("/category", categoryController.getAll.bind(categoryController));
        application.get("/category/:id", categoryController.getById.bind(categoryController))
    }
}