import iConfig from '../common/IConfig.interface';
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
    },
    databse: {
        host: "localhost",
        port: 3306,
        user: "root",
        password: "root",
        database: "projekat",
        charset: "utf8",
        timezone: "+01:00",
    },
};

export default Config;