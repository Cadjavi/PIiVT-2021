import Ajv from "ajv";

const ajv = new Ajv();

interface IAddToCart {
  articleId: number;
  quantity: number;
}

const IAddToCartValidator = ajv.compile({
  type: "object",
  properties: {
    articleId: {
      type: "integer",
      minimum: 1,
    },
    quantity: {
      type: "number",
      minimum: 0,
    },
  },
  required: ["articleId", "quantity"],
  additionalProperties: false,
});

export { IAddToCartValidator };
export default IAddToCart;
