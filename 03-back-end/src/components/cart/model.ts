import IModel from "../../common/IModel.interface";
import ArticleModel from "../article/model";
import UserModel from "../user/model";

type OrderStatus = "pending" | "rejected" | "accepted" | "completed";

class OrderModel implements IModel {
  orderId: number;
  createdAt: Date;
  status: OrderStatus;
}

class CartArticleModel implements IModel {
  cartArticleId: number;
  quantity: number;
  articleId: number;
  article: ArticleModel;
}

export default class CartModel implements IModel {
  cartId: number;
  createdAt: Date;
  userId: number;
  user: UserModel;
  articles: CartArticleModel[] = [];
  order?: OrderModel = null;
}

export { CartArticleModel };
export { OrderModel };
export { OrderStatus };