const getUserMetaFromCookie = (req, res, next) => {
    const [userId, isNewUser] = req.cookies.user.split('|')
    req.userId = userId || null;
    req.isNewUser = isNewUser || null;
    next()
  }

module.exports = {
    getUserMetaFromCookie
}