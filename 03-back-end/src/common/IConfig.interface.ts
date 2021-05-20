export default interface IConfig {
    server: {
        port: number,
        static: {
            path: string,
            route: string,
            cacheControl: boolean,
            dotfiles: string,
            etag: boolean,
            index: boolean,
            maxAge: number,
        }
    },
    databse: {
        host: string,
        port: number,
        user: string,
        password: string,
        database: string,
        charset: string,
        timezone: string,
    },
    fileUpload: {
        maxSize: number;
        maxFiles: number;
        timeout: number;
        temporaryDirectory: string;
        uploadDestinationDirectory: string;
    },
}