const dbClient = require('./DBClient')

module.exports = {

    // users 

    getAllUsers: async () => {
        try {
            const result = await dbClient.result(
                'SELECT user_id, is_new FROM "user"'
                )
            return result.rows;
        } catch (e) {
            console.error(e)
            return 'ERROR getting all users';
        }
    },

    getUser: async (userId) => {
        try {
            const user = await dbClient.one(
                'SELECT * FROM "user" WHERE user_id = $1', 
                [userId])
            return user;
        } catch (e) {
            console.error(e)
            return 'ERROR getting all users';
        }
    },

    createNewUser: async () => {
        try {
            await dbClient.result(
                'INSERT INTO "user" (is_new) VALUES (TRUE)'
                )
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    setUserAsNotNew: async (userId) => {
        try {
            await dbClient.result(
                'UPDATE "user" SET is_new = false WHERE user_id = $1', 
                [userId])
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    // funnel

    getProducts: async (productsShow, seenProducts) => {
        console.log('seenProducts', seenProducts)
        try {
            const result = await dbClient.result(
                `SELECT 
                    * 
                FROM 
                    product 
                WHERE NOT 
                    (product_id = ANY ($1))  
                ORDER BY 
                    RANDOM() 
                LIMIT $2;`,
                [seenProducts, productsShow])
            return result.rows;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    seenProducts: async (userId) => {
        try {
            const result = await dbClient.result(
                `SELECT
                    fk_product_id
                FROM
                    rating
                WHERE
                    fk_user_id = $1;`,
                [userId])
            return result.rows.map(row => row.fk_product_id * 1);
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    rateProduct: async (productId, userId, like) => {
        try {
            await dbClient.result(
                'INSERT INTO "rating" (fk_product_id, fk_user_id, "like") VALUES ($1,$2,$3)', 
                [productId,userId,like])
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

    // abtest

    setAbtestAllocationConversion: async (allocationId) => {
        try {
            return await dbClient.none(
                `UPDATE 
                    abtest_allocation
                SET 
                    "conversion" = true
                WHERE 
                    allocation_id = $1;`, [allocationId])
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    getAbtestByName: async (abtestName) => {
        try {
            return await dbClient.one(
                'SELECT abtest_id, groups FROM abtest WHERE name = $1', 
                [abtestName])
        } catch (e) {
            console.error(e)
            return {abtest_id: -1, groups: []};
        }
    },

    startExperiment: async (userId, abtestName, group, abtestId) => {
        try {
            const result = await dbClient.one(
                `INSERT INTO 
                    abtest_allocation
                    ("name", "group", fk_user_id, fk_abtest_id)
                 VALUES 
                    ($1,$2,$3,$4)
                 RETURNING 
                    allocation_id`, 
                 [abtestName, group, userId, abtestId])
            return Number(result.allocation_id);
        } catch (e) {
            if(e.constraint === 'abtest_allocation_pkey')
                throw('abtest already exists')
            console.log(e)
            return false;
        }
    },
};