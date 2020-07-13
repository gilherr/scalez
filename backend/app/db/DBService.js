const dbClient = require('./DBClient')

module.exports = {
    getAllUsers: async () => {
        try {
            const result = await dbClient.result('SELECT * FROM "user"')
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
    }
};