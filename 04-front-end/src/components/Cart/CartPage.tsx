import BasePage from "../BasePage/BasePage";
import CartModel from "../../../../03-back-end/src/components/cart/model";
import { Card, InputGroup, Form, Button } from "react-bootstrap";
import EventRegister from "../../api/EventRegister";
import CartService from "../../services/CartService";
import * as path from "path";
import "./CartPage.sass";
import ConfirmAction from "../Misc/ConfirmAction";

interface CartPageState {
  cart: CartModel | null;
  showDeleteDialog: boolean;
  deleteDialogYesHandler: () => void;
  deleteDialogNoHandler: () => void;
}

export default class CartPage extends BasePage<{}> {
  state: CartPageState;

  constructor(props: any) {
    super(props);

    this.state = {
      cart: null,
      showDeleteDialog: false,
      deleteDialogYesHandler: () => {},
      deleteDialogNoHandler: () => {
        this.setState({
          showDeleteDialog: false,
        });
      },
    };
  }

  private getCartData() {
    CartService.getCart().then((res) => {
      this.setState({
        cart: res,
      });
    });
  }

  componentDidMount() {
    this.getCartData();
    EventRegister.on("CART_EVENT", this.getCartData.bind(this));
  }

  componentWillUnmount() {
    EventRegister.off("CART_EVENT", this.getCartData.bind(this));
  }

  getThumbPath(url: string): string {
    const directory = path.dirname(url);
    const extension = path.extname(url);
    const filename = path.basename(url, extension);
    return directory + "/" + filename + "-thumb" + extension;
  }

  private onChangeQuantityInput(
    cartArticleId: number
  ): (event: React.ChangeEvent<HTMLInputElement>) => void {
    return (event: React.ChangeEvent<HTMLInputElement>) => {
      this.setState((state: CartPageState) => {
        if (state.cart === null) {
          return state;
        }

        for (let i = 0; i < state.cart.articles.length; i++) {
          if (state.cart.articles[i].cartArticleId === cartArticleId) {
            state.cart.articles[i].quantity = Number(event.target.value);
            break;
          }
        }

        return state;
      });
    };
  }

  private getUpdateQuantityHandler(cartArticleId: number): () => void {
    return () => {
      if (this.state.cart === null) return;

      for (let i = 0; i < this.state.cart.articles.length; i++) {
        if (this.state.cart.articles[i].cartArticleId === cartArticleId) {
          CartService.setToCart(
            this.state.cart.articles[i].articleId,
            this.state.cart.articles[i].quantity
          );
          return;
        }
      }
    };
  }

  private getDeleteHandler(cartArticleId: number): () => void {
    return () => {
      this.setState({
        showDeleteDialog: true,
        deleteDialogYesHandler: () => {
          if (this.state.cart === null) {
            return this.setState({
              showDeleteDialog: false,
            });
          }

          for (let i = 0; i < this.state.cart.articles.length; i++) {
            if (this.state.cart.articles[i].cartArticleId === cartArticleId) {
              CartService.setToCart(this.state.cart.articles[i].articleId, 0);
              return this.setState({
                showDeleteDialog: false,
              });
            }
          }
        },
      });
    };
  }

  renderMain(): JSX.Element {
    if (this.state.cart === null) {
      return (
        <Card>
          <Card.Header>
            <Card.Title>
              <h1>Your shopping cart</h1>
            </Card.Title>
          </Card.Header>
          <Card.Body>
            <p>Your shopping cart is empty.</p>
          </Card.Body>
        </Card>
      );
    }

    return (
      <>
        {this.state.showDeleteDialog ? (
          <ConfirmAction
            title="Remove from cart?"
            message="Are you sure you want to remove this article from the cart?"
            yesHandler={this.state.deleteDialogYesHandler}
            noHandler={this.state.deleteDialogNoHandler}
          />
        ) : (
          ""
        )}

        <Card>
          <Card.Header>
            <Card.Title>
              <h1>Your shopping cart</h1>
            </Card.Title>
          </Card.Header>
          <Card.Body>
            <table className="table table-sm cart-table">
              <thead>
                <tr>
                  <th colSpan={2}>Article</th>
                  <th>Quantity</th>
                  <th>Price</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {this.state.cart.articles.map((ca) => (
                  <tr key={"cart-article-" + ca.cartArticleId}>
                    <td>
                      <b className="h5">{ca.article.title}</b>
                      <br />
                      <small>({ca.article.category?.name})</small>
                    </td>
                    <td>&euro; {Number(ca.article.currentPrice).toFixed(2)}</td>
                    <td>
                      <InputGroup>
                        <Form.Control
                          type="number"
                          min="0"
                          max="100"
                          step="1"
                          value={ca.quantity}
                          onChange={this.onChangeQuantityInput(
                            ca.cartArticleId
                          )}
                        />
                        <InputGroup.Append>
                          <Button
                            variant="primary"
                            onClick={this.getUpdateQuantityHandler(
                              ca.cartArticleId
                            )}
                          >
                            Update
                          </Button>
                        </InputGroup.Append>
                      </InputGroup>
                    </td>
                    <td>
                      &euro;{" "}
                      {Number(ca.article.currentPrice * ca.quantity).toFixed(2)}
                    </td>
                    <td>
                      <Button
                        variant="danger"
                        onClick={this.getDeleteHandler(ca.cartArticleId)}
                      >
                        Delete
                      </Button>
                    </td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr>
                  <td colSpan={4}></td>

                  <td className="md-3">
                    Sum &euro;{" "}
                    {this.state.cart.articles
                      .map((ca) => ca.article.currentPrice * ca.quantity)
                      .reduce((sum, value) => sum + value, 0)
                      .toFixed(2)}
                  </td>
                  <td>
                    <Button>Ajmo</Button>
                  </td>
                </tr>
              </tfoot>
            </table>
          </Card.Body>
        </Card>
      </>
    );
  }
}
