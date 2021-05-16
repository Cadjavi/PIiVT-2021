import Ajv from "ajv";


interface IAddCategory{
    name: string;
    imagePath: string;
    parentCategoryId: number | null;
}

const ajv = new Ajv();

const  IAddCategoryValidator = ajv.compile({
    type: "object",
    properties: {
        name: {
            type: "string",
            minlenght: 2,
            maxlenght: 64,
        },
        imagePath: {
            type: "string",
            maxlenght: 255,
            pattern: "\.(png|jpg)$",
        },
        parentCategory: {
            type: [ "integer", "null;" ],
            minimum: 1,
        },
    },
    required: [
        "name" ,
        "imagePath",
    ],
    additionalProperties: false,
});

export { IAddCategory };
export { IAddCategoryValidator }
