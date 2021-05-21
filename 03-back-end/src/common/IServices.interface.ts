import ArticleService from '../components/article/service';
import CategoryService from '../components/category/service';
import FeatureService from '../components/feature/service';
import AdministratorService from '../components/admin/service';

export default interface IServices {
    categoryService: CategoryService;
    featureService: FeatureService;
    articleService: ArticleService;
    administratorService: AdministratorService;
}