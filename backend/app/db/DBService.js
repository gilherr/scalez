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
            return 'ERROR getting user';
        }
    },

    getAllProductsSeenByUser: async (userId) => {
        try {
            const user = await dbClient.result(
                `SELECT 
                    product_id, "like",
                    meta AS product_meta, 
                    created_at AS rating_timestamp
                FROM
                    rating
                INNER JOIN 
                    product 
                ON 
                    product.product_id = rating.fk_product_id
                WHERE
                    fk_user_id = $1`, 
                [userId])
            return user.rows;
        } catch (e) {
            console.error(e)
            return 'ERROR getting users seen products';
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

    setUserIsNewStatus: async (userId, isNew) => {
        try {
            await dbClient.result(
                'UPDATE "user" SET is_new = $1 WHERE user_id = $2', 
                [isNew, userId])
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    truncateRatings: async () => {
        try {
        console.log('in backend truncating 2');

            await dbClient.result('TRUNCATE rating')
            return true;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    // funnel

    getProducts: async (productsShow, seenProductsIds) => {
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
                [seenProductsIds, productsShow])
            return result.rows;
        } catch (e) {
            console.error(e)
            return false;
        }
    },

    seenProductsIds: async (userId) => {
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
                `INSERT INTO 
                    "rating" (fk_product_id, fk_user_id, "like") 
                VALUES 
                    ($1,$2,$3)
                ON CONFLICT (fk_product_id, fk_user_id) DO 
                    UPDATE SET 
                        "like" = $3;
                `, 
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
                ON CONFLICT(fk_user_id, fk_abtest_id) 
                    DO UPDATE SET name=EXCLUDED.name
                RETURNING 
                    allocation_id, "group"`, 
                 [abtestName, group, userId, abtestId])
            return { 
                allocation_id: Number(result.allocation_id), 
                group: result.group 
            } ;
        } catch (e) {
            if(e.constraint === 'abtest_allocation_pkey')
                throw('abtest already exists')
            console.log(e)
            return false;
        }
    },
};