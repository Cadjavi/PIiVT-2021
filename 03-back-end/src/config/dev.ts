import iConfig from './IConfig.interface';
const Config: iConfig = {
    server:{
        port: 400,
        static: {
            route: "/static",
            path: "static/",
            cacheControl: false,
            dotfiles: "deny",
            etag: false,
            index: false,
            maxAge: 3600000
        },
    } ,
};

export default Config;