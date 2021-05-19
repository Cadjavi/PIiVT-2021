import IModelAdapterOptionsInterface from "../../common/IModelAdapterOptions.interface";
import BaseService from "../../common/BaseService";
import FeatureModel from "./model";
import { IAddFeature } from "./dto/AddFeature";
import { IEditFeature } from "./dto/EditFeature";
import IErrorResponse from "../../common/IErrorRrsponse.interface";
import CategoryModel from "../category/model";

class FeatureModelApdaterOptions implements IModelAdapterOptionsInterface {
  loadCategory: boolean = false;
}

class FeatureService extends BaseService<FeatureModel> {
  protected async adaptModel(
    data: any,
    options: Partial<FeatureModelApdaterOptions>
  ): Promise<FeatureModel> {
    const item: FeatureModel = new FeatureModel();

    item.featureId = +data?.feature_id;
    item.name = data?.name;
    item.categoryId = +data?.category_id;

    if (options.loadCategory && item.categoryId) {
      const result = await this.services.categoryService.getById(item.categoryId);

      item.category = result as CategoryModel;
    }

    return item;
  }

  public async getById(
    featureId: number,
    options: Partial<FeatureModelApdaterOptions> = {}
  ): Promise<FeatureModel | null | IErrorResponse> {
    return await this.getByIdFromTable("feature", featureId, options);
  }

  public async getAllByCategoryId(
    categoryId: number
  ): Promise<FeatureModel[]> {
    const allFeatures: FeatureModel[] = [];

    const firstParent: CategoryModel = (await this.services.categoryService.getById(
      categoryId
    )) as CategoryModel;
    let currnetPatent: CategoryModel = firstParent;

    while (currnetPatent !== null) {
      allFeatures.push(
        ...((await this.getAllByFieldNameFromTable(
          "feature",
          "category_id",
          currnetPatent.categoryId
        )) as FeatureModel[])
      );
      currnetPatent = await this.services.categoryService.getById(
        currnetPatent.parentCategoryId
      )as CategoryModel | null;

        
      
    }

    return allFeatures;
  }

  public async add(data: IAddFeature): Promise<FeatureModel | IErrorResponse> {
    return new Promise<FeatureModel | IErrorResponse>((resolve) => {
      const sql = "INSERT feature SET name = ?, category_id = ?;";
      this.db
        .execute(sql, [data.name, data.categoryId])
        .then(async (result) => {
          const insertInfo: any = result[0];
          const newId: number = +insertInfo?.insertId;
          resolve(await this.getById(newId));
        })
        .catch((error) => {
          resolve({
            errorCode: error?.errno,
            errorMessage: error?.sqlMessage,
          });
        });
    });
  }

  public async edit(
    featureId: number,
    data: IEditFeature,
    options: Partial<FeatureModelApdaterOptions> = {}
  ): Promise<FeatureModel | IErrorResponse> {
    return new Promise<FeatureModel | IErrorResponse>((resolve) => {
      const sql = "UPDATE feature SET name = ? WHERE feature_id = ?;";
      this.db
        .execute(sql, [data.name, featureId])
        .then(async (result) => {
          resolve(await this.getById(featureId, options));
        })
        .catch((error) => {
          resolve({
            errorCode: error?.errno,
            errorMessage: error?.sqlMessage,
          });
        });
    });
  }
}

export default FeatureService;
