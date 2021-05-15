import * as mysql2 from 'mysql2/promise';

export default interface IApplicationResourses {
    databaseConnection: mysql2.Connection;
}