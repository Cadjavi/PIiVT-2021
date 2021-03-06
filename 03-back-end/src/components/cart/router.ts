import IRouter from "../../common/IRouter.interface";
import CartController from "./controller";
import * as express from "express";
import IApplicationResourses from "../../common/IApplicationResourses.interface";
import AuthMiddleware from "../../middleware/auth.middleware";

export default class CartRouter implements IRouter {
  public setupRoutes(
    application: express.Application,
    resourses: IApplicationResourses
  ) {
    const cartController: CartController = new CartController(resourses);

    application.get(
      "/cart",
      AuthMiddleware.getVerifier("user"),
      cartController.getCurrentUserCart.bind(cartController)
    );
    application.post(
      "/cart",
      AuthMiddleware.getVerifier("user"),
      cartController.addToCart.bind(cartController)
    );
    application.put(
      "/cart",
      AuthMiddleware.getVerifier("user"),
      cartController.setInCart.bind(cartController)
    );
    application.post(
      "/cart/order",
      AuthMiddleware.getVerifier("user"),
      cartController.makeOrder.bind(cartController)
    );
    application.get(
      "/cart/order/my",
      AuthMiddleware.getVerifier("user"),
      cartController.getAllOrdersForCurrentUser.bind(cartController)
    );
    application.get(
      "/order",
      AuthMiddleware.getVerifier("administrator"),
      cartController.getAllOrders.bind(cartController)
    );
    application.get(
      "/user/:uid/order",
      AuthMiddleware.getVerifier("administrator"),
      cartController.getAllOrdersByUserId.bind(cartController)
    );
    application.put(
      "/cart/:cid",
      AuthMiddleware.getVerifier("administrator"),
      cartController.setStatus.bind(cartController)
    );
  }
}
