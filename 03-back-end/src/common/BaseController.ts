import IApplicationResources from './IApplicationResourses.interface';
import IServices from './IServices.interface';

export default abstract class BaseController{
    private resourses: IApplicationResources;

    constructor(resourses: IApplicationResources){
        this.resourses = resourses;
    }

    protected get services(): IServices {
        return this.resourses.services
    }
}