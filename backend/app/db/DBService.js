const dbClient = require('./DBClient')

module.exports = {

    // users 

    getAllUsers: async () => {
        try {
            const result = await dbClient.result('SELECT user_id, is_new FROM "user"')
            return result.rows;
        } catch (e) {
            console.error(e)
            return 'ERROR getting all users';
        }
    },

    getUser: async (userId) => {
        try {
            const user = await dbClient.one('SELECT * FROM "user" WHERE user_id = $1', [userId])
            return user;
        } catch (e) {
            console.error(e)
            return 'ERROR getting all users';
        }
    },

    createNewUser: async () => {
        try {
            await dbClient.result('INSERT INTO "user" (is_new) VALUES (TRUE)')
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    setUserAsNotNew: async (userId) => {
        try {
            await dbClient.result('UPDATE "user" SET is_new = false WHERE user_id = $1', [userId])
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    // funnel

    rateProduct: async (productId, userId, like) => {
        try {
            await dbClient.result('INSERT INTO "rating" (fk_product_id, fk_user_id, "like") VALUES ($1,$2,$3)', [productId,userId,like])
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    // closet

    getUserCloset: async (userId) => {
        try {
            const result = await dbClient.result(
                `SELECT
                    meta
                FROM
                    product
                INNER JOIN rating
                    ON product.product_id = rating.fk_product_id
                WHERE
                    rating.like = true 
                    AND 
                    rating.fk_user_id = $1`, [userId])
            return result.rows;
        } catch (e) {
            console.error(e)
            return false;
        }
    },
};